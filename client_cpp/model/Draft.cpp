#include "Draft.h"

Draft::Draft()
    : m_currentRound(1)
    , m_currentPick(1)
    , m_direction("left")
    , m_status("in_progress")
{
}

Draft::Draft(const QString& lobbyId)
    : m_lobbyId(lobbyId)
    , m_currentRound(1)
    , m_currentPick(1)
    , m_direction("left")
    , m_status("in_progress")
{
}

Draft::Draft(const QJsonObject& json)
    : m_currentRound(1)
    , m_currentPick(1)
    , m_direction("left")
    , m_status("in_progress")
{
    *this = fromJson(json);
}

void Draft::advanceRound()
{
    if (m_currentRound < 3) {
        m_currentRound++;
        m_currentPick = 1;
        m_direction = (m_currentRound % 2 == 0) ? "right" : "left";
    } else {
        m_status = "completed";
    }
}

void Draft::nextPick()
{
    m_currentPick++;
}

QJsonObject Draft::toJson() const
{
    QJsonObject json;
    json["id"] = m_id;
    json["lobby_id"] = m_lobbyId;
    json["current_round"] = m_currentRound;
    json["current_pick"] = m_currentPick;
    json["direction"] = m_direction;
    json["status"] = m_status;
    json["started_at"] = m_startedAt.toString(Qt::ISODate);
    json["completed_at"] = m_completedAt.toString(Qt::ISODate);
    return json;
}

Draft Draft::fromJson(const QJsonObject& json)
{
    Draft draft;
    draft.m_id = json["id"].toString();
    draft.m_lobbyId = json["lobby_id"].toString();
    draft.m_currentRound = json["current_round"].toInt();
    draft.m_currentPick = json["current_pick"].toInt();
    draft.m_direction = json["direction"].toString();
    draft.m_status = json["status"].toString();
    draft.m_startedAt = QDateTime::fromString(json["started_at"].toString(), Qt::ISODate);
    draft.m_completedAt = QDateTime::fromString(json["completed_at"].toString(), Qt::ISODate);
    return draft;
}
