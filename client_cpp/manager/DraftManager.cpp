#ifndef DRAFT_H
#define DRAFT_H

#include <QString>
#include <QJsonObject>
#include <QDateTime>

class Draft
{
public:
    Draft();
    Draft(const QString& lobbyId);
    Draft(const QJsonObject& json);

    QString id() const { return m_id; }
    QString lobbyId() const { return m_lobbyId; }
    int currentRound() const { return m_currentRound; }
    int currentPick() const { return m_currentPick; }
    QString direction() const { return m_direction; }
    QString status() const { return m_status; }
    QDateTime startedAt() const { return m_startedAt; }
    QDateTime completedAt() const { return m_completedAt; }

    void setId(const QString& id) { m_id = id; }
    void setLobbyId(const QString& id) { m_lobbyId = id; }
    void setCurrentRound(int round) { m_currentRound = round; }
    void setCurrentPick(int pick) { m_currentPick = pick; }
    void setDirection(const QString& dir) { m_direction = dir; }
    void setStatus(const QString& status) { m_status = status; }
    void setStartedAt(const QDateTime& time) { m_startedAt = time; }
    void setCompletedAt(const QDateTime& time) { m_completedAt = time; }

    bool isCompleted() const { return m_status == "completed"; }
    bool isInProgress() const { return m_status == "in_progress"; }

    void advanceRound();
    void nextPick();

    QJsonObject toJson() const;
    static Draft fromJson(const QJsonObject& json);

    bool isValid() const { return !m_id.isEmpty() && !m_lobbyId.isEmpty(); }

private:
    QString m_id;
    QString m_lobbyId;
    int m_currentRound;
    int m_currentPick;
    QString m_direction;
    QString m_status;
    QDateTime m_startedAt;
    QDateTime m_completedAt;
};

#endif // DRAFT_H
