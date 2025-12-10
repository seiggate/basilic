#include "LobbyPlayer.h"

LobbyPlayer::LobbyPlayer()
    : m_seatPosition(0)
    , m_isCreator(false)
{
}

LobbyPlayer::LobbyPlayer(const QString& lobbyId, const QString& name, int seat)
    : m_lobbyId(lobbyId)
    , m_playerName(name)
    , m_seatPosition(seat)
    , m_isCreator(false)
{
}

LobbyPlayer::LobbyPlayer(const QJsonObject& json)
    : m_seatPosition(0)
    , m_isCreator(false)
{
    *this = fromJson(json);
}

QJsonObject LobbyPlayer::toJson() const
{
    QJsonObject json;
    json["id"] = m_id;
    json["lobby_id"] = m_lobbyId;
    json["player_name"] = m_playerName;
    json["seat_position"] = m_seatPosition;
    json["is_creator"] = m_isCreator;
    json["joined_at"] = m_joinedAt.toString(Qt::ISODate);
    return json;
}

LobbyPlayer LobbyPlayer::fromJson(const QJsonObject& json)
{
    LobbyPlayer player;
    player.m_id = json["id"].toString();
    player.m_lobbyId = json["lobby_id"].toString();
    player.m_playerName = json["player_name"].toString();
    player.m_seatPosition = json["seat_position"].toInt();
    player.m_isCreator = json["is_creator"].toBool();
    player.m_joinedAt = QDateTime::fromString(json["joined_at"].toString(), Qt::ISODate);
    return player;
}
