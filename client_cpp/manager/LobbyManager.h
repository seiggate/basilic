#ifndef LOBBYMANAGER_H
#define LOBBYMANAGER_H

#include <QObject>
#include <QString>
#include <QVector>
#include <functional>
#include "SupabaseClient.h"
#include "Lobby.h"
#include "LobbyPlayer.h"

class LobbyManager : public QObject
{
    Q_OBJECT

public:
    explicit LobbyManager(SupabaseClient *client, QObject *parent = nullptr);
    ~LobbyManager();

    void createLobby(const QString &name,
                     const QString &setCode,
                     const QString &creatorName,
                     int maxPlayers,
                     std::function<void(const Lobby&, const QString&)> callback);

    void joinLobby(const QString &lobbyCode,
                   const QString &playerName,
                   std::function<void(const Lobby&, const QString&)> callback);

    void leaveLobby(const QString &lobbyId,
                    const QString &playerId,
                    std::function<void(bool, const QString&)> callback);

    void getLobbies(const QString &status = "waiting",
                    std::function<void(const QVector<Lobby>&, const QString&)> callback = nullptr);

    void getLobby(const QString &lobbyCode,
                  std::function<void(const Lobby&, const QString&)> callback);

    void updateLobbyStatus(const QString &lobbyId,
                          const QString &status,
                          std::function<void(bool, const QString&)> callback);

    void startDraft(const QString &lobbyId,
                    std::function<void(const QString&, const QString&)> callback);

signals:
    void lobbyCreated(const Lobby &lobby);
    void lobbyJoined(const Lobby &lobby);
    void lobbyUpdated(const Lobby &lobby);
    void error(const QString &message);

private:
    SupabaseClient *m_client;

    Lobby parseLobby(const QJsonObject &data);
    QVector<Lobby> parseLobbies(const QJsonArray &data);
    QVector<LobbyPlayer> parsePlayers(const QJsonArray &data);
    QString generateLobbyCode();
};

#endif
