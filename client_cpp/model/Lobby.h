#ifndef LOBBY_H
#define LOBBY_H

#include "LobbyPlayer.h"
#include <QString>
#include <QVector>
#include <QJsonObject>
#include <QDateTime>

class Lobby
{
public:
    Lobby();
    Lobby(const QString& name, const QString& code, int maxPlayers);
    Lobby(const QJsonObject& json);

    QString id() const { return m_id; }
    QString name() const { return m_name; }
    QString code() const { return m_code; }
    QString creatorName() const { return m_creatorName; }
    QString setCode() const { return m_setCode; }
    int maxPlayers() const { return m_maxPlayers; }
    QString status() const { return m_status; }
    QDateTime createdAt() const { return m_createdAt; }
    QDateTime updatedAt() const { return m_updatedAt; }
    QDateTime lastActivity() const { return m_lastActivity; }

    QVector<LobbyPlayer> players() const { return m_players; }
    int currentPlayerCount() const { return m_players.size(); }
    bool isFull() const { return m_players.size() >= m_maxPlayers; }

    void setId(const QString& id) { m_id = id; }
    void setName(const QString& name) { m_name = name; }
    void setCode(const QString& code) { m_code = code; }
    void setCreatorName(const QString& name) { m_creatorName = name; }
    void setSetCode(const QString& code) { m_setCode = code; }
    void setMaxPlayers(int max) { m_maxPlayers = max; }
    void setStatus(const QString& status) { m_status = status; }
    void setCreatedAt(const QDateTime& time) { m_createdAt = time; }
    void setUpdatedAt(const QDateTime& time) { m_updatedAt = time; }
    void setLastActivity(const QDateTime& time) { m_lastActivity = time; }

    void setPlayers(const QVector<LobbyPlayer>& players) { m_players = players; }
    void addPlayer(const LobbyPlayer& player) { m_players.append(player); }

    QJsonObject toJson() const;
    static Lobby fromJson(const QJsonObject& json);

    bool isValid() const { return !m_id.isEmpty() && !m_code.isEmpty(); }

private:
    QString m_id;
    QString m_name;
    QString m_code;
    QString m_creatorName;
    QString m_setCode;
    int m_maxPlayers;
    QString m_status;
    QDateTime m_createdAt;
    QDateTime m_updatedAt;
    QDateTime m_lastActivity;

    QVector<LobbyPlayer> m_players;
};

#endif // LOBBY_H
