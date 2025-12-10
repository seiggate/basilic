#include "DraftPack.h"
#include <QJsonArray>

DraftPack::DraftPack()
    : m_playerSeat(0)
    , m_roundNumber(1)
    , m_currentOwnerSeat(0)
{
}

DraftPack::DraftPack(const QString& draftId, int playerSeat, int roundNumber)
    : m_draftId(draftId)
    , m_playerSeat(playerSeat)
    , m_roundNumber(roundNumber)
    , m_currentOwnerSeat(playerSeat)
{
}

DraftPack::DraftPack(const QJsonObject& json)
    : m_playerSeat(0)
    , m_roundNumber(1)
    , m_currentOwnerSeat(0)
{
    *this = fromJson(json);
}

void DraftPack::removeCard(const QString& cardId)
{
    for (int i = 0; i < m_cards.size(); ++i) {
        if (m_cards[i].id() == cardId) {
            m_cards.remove(i);
            break;
        }
    }
}

QJsonObject DraftPack::toJson() const
{
    QJsonObject json;
    json["id"] = m_id;
    json["draft_id"] = m_draftId;
    json["player_seat"] = m_playerSeat;
    json["round_number"] = m_roundNumber;
    json["current_owner_seat"] = m_currentOwnerSeat;
    json["created_at"] = m_createdAt.toString(Qt::ISODate);

    QJsonArray cardsArray;
    for (const Card& card : m_cards) {
        cardsArray.append(card.toJson());
    }
    json["cards"] = cardsArray;

    return json;
}

DraftPack DraftPack::fromJson(const QJsonObject& json)
{
    DraftPack pack;
    pack.m_id = json["id"].toString();
    pack.m_draftId = json["draft_id"].toString();
    pack.m_playerSeat = json["player_seat"].toInt();
    pack.m_roundNumber = json["round_number"].toInt();
    pack.m_currentOwnerSeat = json["current_owner_seat"].toInt();
    pack.m_createdAt = QDateTime::fromString(json["created_at"].toString(), Qt::ISODate);

    QJsonArray cardsArray = json["cards"].toArray();
    for (const QJsonValue& value : cardsArray) {
        pack.m_cards.append(Card::fromJson(value.toObject()));
    }

    return pack;
}
