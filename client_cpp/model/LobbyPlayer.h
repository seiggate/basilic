#ifndef LOBBYPLAYER_H
#define LOBBYPLAYER_H

#include <QString>
#include <QJsonObject>
#include <QDateTime>

class LobbyPlayer
{
public:
    LobbyPlayer();
    LobbyPlayer(const QString& lobbyId, const QString& name, int seat);
    LobbyPlayer(const QJsonObject& json);

    QString id() const { return m_id; }
    QString lobbyId() const { return m_lobbyId; }
    QString playerName() const { return m_playerName; }
    int seatPosition() const { return m_seatPosition; }
    bool isCreator() const { return m_isCreator; }
    QDateTime joinedAt() const { return m_joinedAt; }

    void setId(const QString& id) { m_id = id; }
    void setLobbyId(const QString& id) { m_lobbyId = id; }
    void setPlayerName(const QString& name) { m_playerName = name; }
    void setSeatPosition(int seat) { m_seatPosition = seat; }
    void setIsCreator(bool creator) { m_isCreator = creator; }
    void setJoinedAt(const QDateTime& time) { m_joinedAt = time; }

    QJsonObject toJson() const;
    static LobbyPlayer fromJson(const QJsonObject& json);

    bool isValid() const { return !m_id.isEmpty() && !m_lobbyId.isEmpty(); }

private:
    QString m_id;
    QString m_lobbyId;
    QString m_playerName;
    int m_seatPosition;
    bool m_isCreator;
    QDateTime m_joinedAt;
};

#endif // LOBBYPLAYER_H
