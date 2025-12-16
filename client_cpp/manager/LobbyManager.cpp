#include "LobbyManager.h"
#include <QJsonArray>
#include <QJsonObject>
#include <QDebug>
#include <QRandomGenerator>

LobbyManager::LobbyManager(SupabaseClient *client, QObject *parent)
    : QObject(parent)
    , m_client(client)
{
}

LobbyManager::~LobbyManager()
{
}

QString LobbyManager::generateLobbyCode()
{
    const QString chars = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789";
    QString code;
    for (int i = 0; i < 6; ++i) {
        int index = QRandomGenerator::global()->bounded(chars.length());
        code.append(chars[index]);
    }
    return code;
}

void LobbyManager::createLobby(const QString &name,
                               const QString &setCode,
                               const QString &creatorName,
                               int maxPlayers,
                               std::function<void(const Lobby&, const QString&)> callback)
{
    if (!m_client || !m_client->isInitialized()) {
        if (callback) callback(Lobby(), "Database client not initialized");
        return;
    }

    QString lobbyCode = generateLobbyCode();

    QJsonObject lobbyData;
    lobbyData["name"] = name;
    lobbyData["code"] = lobbyCode;
    lobbyData["set_code"] = setCode;
    lobbyData["creator_name"] = creatorName;
    lobbyData["max_players"] = maxPlayers;
    lobbyData["status"] = "waiting";

    m_client->insert("lobbies", lobbyData,
        [this, creatorName, callback](const QJsonObject &data, const QString &error) {
            if (!error.isEmpty()) {
                if (callback) callback(Lobby(), error);
                emit this->error(error);
                return;
            }

            QString lobbyId = data["id"].toString();

            QJsonObject playerData;
            playerData["lobby_id"] = lobbyId;
            playerData["player_name"] = creatorName;
            playerData["is_creator"] = true;
            playerData["seat_position"] = 0;

            this->m_client->insert("lobby_players", playerData,
                [this, lobbyId, callback](const QJsonObject &playerResult, const QString &playerError) {
                    if (!playerError.isEmpty()) {
                        if (callback) callback(Lobby(), playerError);
                        return;
                    }

                    this->getLobby(lobbyId, callback);
                });
        });
}

void LobbyManager::joinLobby(const QString &lobbyCode,
                             const QString &playerName,
                             std::function<void(const Lobby&, const QString&)> callback)
{
    if (!m_client || !m_client->isInitialized()) {
        if (callback) callback(Lobby(), "Database client not initialized");
        return;
    }

    getLobby(lobbyCode, [this, playerName, callback](const Lobby &lobby, const QString &error) {
        if (!error.isEmpty()) {
            if (callback) callback(Lobby(), error);
            return;
        }

        if (lobby.isFull()) {
            if (callback) callback(Lobby(), "Lobby is full");
            return;
        }

        int nextSeat = lobby.currentPlayerCount();

        QJsonObject playerData;
        playerData["lobby_id"] = lobby.id();
        playerData["player_name"] = playerName;
        playerData["is_creator"] = false;
        playerData["seat_position"] = nextSeat;

        this->m_client->insert("lobby_players", playerData,
            [this, lobby, callback](const QJsonObject &playerResult, const QString &playerError) {
                if (!playerError.isEmpty()) {
                    if (callback) callback(Lobby(), playerError);
                    return;
                }

                this->getLobby(lobby.code(), callback);
            });
    });
}

void LobbyManager::leaveLobby(const QString &lobbyId,
                              const QString &playerId,
                              std::function<void(bool, const QString&)> callback)
{
    if (!m_client || !m_client->isInitialized()) {
        if (callback) callback(false, "Database client not initialized");
        return;
    }

    QString filter = QString("id=eq.%1").arg(playerId);
    m_client->deleteRow("lobby_players", filter, callback);
}

void LobbyManager::getLobbies(const QString &status,
                              std::function<void(const QVector<Lobby>&, const QString&)> callback)
{
    if (!m_client || !m_client->isInitialized()) {
        if (callback) callback(QVector<Lobby>(), "Database client not initialized");
        return;
    }

    QString filter = QString("status=eq.%1&order=created_at.desc").arg(status);
    m_client->select("lobbies", "*,lobby_players(*)", filter,
        [this, callback](const QJsonArray &data, const QString &error) {
            if (!error.isEmpty()) {
                if (callback) callback(QVector<Lobby>(), error);
                return;
            }

            QVector<Lobby> lobbies = parseLobbies(data);
            if (callback) callback(lobbies, QString());
        });
}

void LobbyManager::getLobby(const QString &lobbyCode,
                            std::function<void(const Lobby&, const QString&)> callback)
{
    if (!m_client || !m_client->isInitialized()) {
        if (callback) callback(Lobby(), "Database client not initialized");
        return;
    }

    QString filter = QString("code=eq.%1").arg(lobbyCode);
    m_client->select("lobbies", "*,lobby_players(*)", filter,
        [this, callback](const QJsonArray &data, const QString &error) {
            if (!error.isEmpty()) {
                if (callback) callback(Lobby(), error);
                return;
            }

            if (data.isEmpty()) {
                if (callback) callback(Lobby(), "Lobby not found");
                return;
            }

            Lobby lobby = parseLobby(data.first().toObject());
            if (callback) callback(lobby, QString());
        });
}

void LobbyManager::updateLobbyStatus(const QString &lobbyId,
                                     const QString &status,
                                     std::function<void(bool, const QString&)> callback)
{
    if (!m_client || !m_client->isInitialized()) {
        if (callback) callback(false, "Database client not initialized");
        return;
    }

    QJsonObject updateData;
    updateData["status"] = status;

    QString filter = QString("id=eq.%1").arg(lobbyId);
    m_client->update("lobbies", updateData, filter,
        [callback](const QJsonObject &data, const QString &error) {
            if (!error.isEmpty()) {
                if (callback) callback(false, error);
                return;
            }
            if (callback) callback(true, QString());
        });
}

void LobbyManager::startDraft(const QString &lobbyId,
                              std::function<void(const QString&, const QString&)> callback)
{
    if (!m_client || !m_client->isInitialized()) {
        if (callback) callback(QString(), "Database client not initialized");
        return;
    }

    QJsonObject draftData;
    draftData["lobby_id"] = lobbyId;
    draftData["status"] = "in_progress";
    draftData["current_round"] = 1;
    draftData["current_pick"] = 1;
    draftData["direction"] = "left";

    m_client->insert("drafts", draftData,
        [this, lobbyId, callback](const QJsonObject &data, const QString &error) {
            if (!error.isEmpty()) {
                if (callback) callback(QString(), error);
                return;
            }

            QString draftId = data["id"].toString();

            this->updateLobbyStatus(lobbyId, "in_progress",
                [draftId, callback](bool success, const QString &updateError) {
                    if (!success) {
                        if (callback) callback(QString(), updateError);
                        return;
                    }
                    if (callback) callback(draftId, QString());
                });
        });
}

Lobby LobbyManager::parseLobby(const QJsonObject &data)
{
    return Lobby::fromJson(data);
}

QVector<Lobby> LobbyManager::parseLobbies(const QJsonArray &data)
{
    QVector<Lobby> lobbies;
    for (const QJsonValue &value : data) {
        if (value.isObject()) {
            Lobby lobby = parseLobby(value.toObject());
            if (lobby.isValid()) {
                lobbies.append(lobby);
            }
        }
    }
    return lobbies;
}

QVector<LobbyPlayer> LobbyManager::parsePlayers(const QJsonArray &data)
{
    QVector<LobbyPlayer> players;
    for (const QJsonValue &value : data) {
        if (value.isObject()) {
            LobbyPlayer player = LobbyPlayer::fromJson(value.toObject());
            if (player.isValid()) {
                players.append(player);
            }
        }
    }
    return players;
}
