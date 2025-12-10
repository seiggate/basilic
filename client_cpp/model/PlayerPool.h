#ifndef PLAYERPOOL_H
#define PLAYERPOOL_H

#include "Card.h"
#include <QString>
#include <QVector>
#include <QJsonObject>
#include <QDateTime>

class PlayerPool
{
public:
    PlayerPool();
    PlayerPool(const QString& draftId, int playerSeat);
    PlayerPool(const QJsonObject& json);

    QString id() const { return m_id; }
    QString draftId() const { return m_draftId; }
    int playerSeat() const { return m_playerSeat; }
    QVector<Card> cards() const { return m_cards; }
    QDateTime updatedAt() const { return m_updatedAt; }

    void setId(const QString& id) { m_id = id; }
    void setDraftId(const QString& id) { m_draftId = id; }
    void setPlayerSeat(int seat) { m_playerSeat = seat; }
    void setCards(const QVector<Card>& cards) { m_cards = cards; }
    void setUpdatedAt(const QDateTime& time) { m_updatedAt = time; }

    void addCard(const Card& card);
    int cardCount() const { return m_cards.size(); }

    QJsonObject toJson() const;
    static PlayerPool fromJson(const QJsonObject& json);

    bool isValid() const { return !m_id.isEmpty() && !m_draftId.isEmpty(); }

private:
    QString m_id;
    QString m_draftId;
    int m_playerSeat;
    QVector<Card> m_cards;
    QDateTime m_updatedAt;
};

#endif // PLAYERPOOL_H
