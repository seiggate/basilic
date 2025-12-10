#include "PlayerPool.h"
#include <QJsonArray>

PlayerPool::PlayerPool()
    : m_playerSeat(0)
{
}

PlayerPool::PlayerPool(const QString& draftId, int playerSeat)
    : m_draftId(draftId)
    , m_playerSeat(playerSeat)
{
}

PlayerPool::PlayerPool(const QJsonObject& json)
    : m_playerSeat(0)
{
    *this = fromJson(json);
}

void PlayerPool::addCard(const Card& card)
{
    m_cards.append(card);
    m_updatedAt = QDateTime::currentDateTime();
}

QJsonObject PlayerPool::toJson() const
{
    QJsonObject json;
    json["id"] = m_id;
    json["draft_id"] = m_draftId;
    json["player_seat"] = m_playerSeat;
    json["updated_at"] = m_updatedAt.toString(Qt::ISODate);

    QJsonArray cardsArray;
    for (const Card& card : m_cards) {
        cardsArray.append(card.toJson());
    }
    json["cards"] = cardsArray;

    return json;
}

PlayerPool PlayerPool::fromJson(const QJsonObject& json)
{
    PlayerPool pool;
    pool.m_id = json["id"].toString();
    pool.m_draftId = json["draft_id"].toString();
    pool.m_playerSeat = json["player_seat"].toInt();
    pool.m_updatedAt = QDateTime::fromString(json["updated_at"].toString(), Qt::ISODate);

    QJsonArray cardsArray = json["cards"].toArray();
    for (const QJsonValue& value : cardsArray) {
        pool.m_cards.append(Card::fromJson(value.toObject()));
    }

    return pool;
}
