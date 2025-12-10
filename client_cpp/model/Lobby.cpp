#include "Lobby.h"
#include <QJsonArray>

Lobby::Lobby()
    : m_maxPlayers(8)
    , m_status("waiting")
{
}

Lobby::Lobby(const QString& name, const QString& code, int maxPlayers)
    : m_name(name)
    , m_code(code)
    , m_maxPlayers(maxPlayers)
    , m_status("waiting")
{
}

Lobby::Lobby(const QJsonObject& json)
    : m_maxPlayers(8)
    , m_status("waiting")
{
    *this = fromJson(json);
}

QJsonObject Lobby::toJson() const
{
    QJsonObject json;
    json["id"] = m_id;
    json["name"] = m_name;
    json["code"] = m_code;
    json["creator_name"] = m_creatorName;
    json["set_code"] = m_setCode;
    json["max_players"] = m_maxPlayers;
    json["status"] = m_status;
    json["created_at"] = m_createdAt.toString(Qt::ISODate);
    json["updated_at"] = m_updatedAt.toString(Qt::ISODate);
    json["last_activity"] = m_lastActivity.toString(Qt::ISODate);

    QJsonArray playersArray;
    for (const LobbyPlayer& player : m_players) {
        playersArray.append(player.toJson());
    }
    json["lobby_players"] = playersArray;

    return json;
}

Lobby Lobby::fromJson(const QJsonObject& json)
{
    Lobby lobby;
    lobby.m_id = json["id"].toString();
    lobby.m_name = json["name"].toString();
    lobby.m_code = json["code"].toString();
    lobby.m_creatorName = json["creator_name"].toString();
    lobby.m_setCode = json["set_code"].toString();
    lobby.m_maxPlayers = json["max_players"].toInt();
    lobby.m_status = json["status"].toString();
    lobby.m_createdAt = QDateTime::fromString(json["created_at"].toString(), Qt::ISODate);
    lobby.m_updatedAt = QDateTime::fromString(json["updated_at"].toString(), Qt::ISODate);
    lobby.m_lastActivity = QDateTime::fromString(json["last_activity"].toString(), Qt::ISODate);

    QJsonArray playersArray = json["lobby_players"].toArray();
    for (const QJsonValue& value : playersArray) {
        lobby.m_players.append(LobbyPlayer::fromJson(value.toObject()));
    }

    return lobby;
}
