#ifndef DRAFTPACK_H
#define DRAFTPACK_H

#include "Card.h"
#include <QString>
#include <QVector>
#include <QJsonObject>
#include <QDateTime>

class DraftPack
{
public:
    DraftPack();
    DraftPack(const QString& draftId, int playerSeat, int roundNumber);
    DraftPack(const QJsonObject& json);

    QString id() const { return m_id; }
    QString draftId() const { return m_draftId; }
    int playerSeat() const { return m_playerSeat; }
    int roundNumber() const { return m_roundNumber; }
    QVector<Card> cards() const { return m_cards; }
    int currentOwnerSeat() const { return m_currentOwnerSeat; }
    QDateTime createdAt() const { return m_createdAt; }

    void setId(const QString& id) { m_id = id; }
    void setDraftId(const QString& id) { m_draftId = id; }
    void setPlayerSeat(int seat) { m_playerSeat = seat; }
    void setRoundNumber(int round) { m_roundNumber = round; }
    void setCards(const QVector<Card>& cards) { m_cards = cards; }
    void setCurrentOwnerSeat(int seat) { m_currentOwnerSeat = seat; }
    void setCreatedAt(const QDateTime& time) { m_createdAt = time; }

    void removeCard(const QString& cardId);
    bool isEmpty() const { return m_cards.isEmpty(); }
    int cardCount() const { return m_cards.size(); }

    QJsonObject toJson() const;
    static DraftPack fromJson(const QJsonObject& json);

    bool isValid() const { return !m_id.isEmpty() && !m_draftId.isEmpty(); }

private:
    QString m_id;
    QString m_draftId;
    int m_playerSeat;
    int m_roundNumber;
    QVector<Card> m_cards;
    int m_currentOwnerSeat;
    QDateTime m_createdAt;
};

#endif // DRAFTPACK_H
