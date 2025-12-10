#include "Booster.h"
#include <QRandomGenerator>

Booster::Booster(const QString& setCode)
    : m_setCode(setCode)
{
}

QVector<Card> Booster::generate()
{
    QVector<Card> booster;

    QVector<Card> commons = fetchCardsByRarity("common");
    for (int i = 0; i < COMMONS && !commons.isEmpty(); ++i) {
        booster.append(pickRandom(commons));
    }

    QVector<Card> uncommons = fetchCardsByRarity("uncommon");
    for (int i = 0; i < UNCOMMONS && !uncommons.isEmpty(); ++i) {
        booster.append(pickRandom(uncommons));
    }

    double mythicRoll = QRandomGenerator::global()->generateDouble();
    if (mythicRoll < MYTHIC_RATE) {
        QVector<Card> mythics = fetchCardsByRarity("mythic");
        if (!mythics.isEmpty()) {
            booster.append(pickRandom(mythics));
        } else {
            QVector<Card> rares = fetchCardsByRarity("rare");
            if (!rares.isEmpty()) {
                booster.append(pickRandom(rares));
            }
        }
    } else {
        QVector<Card> rares = fetchCardsByRarity("rare");
        if (!rares.isEmpty()) {
            booster.append(pickRandom(rares));
        }
    }

    return booster;
}

QVector<QVector<Card>> Booster::generateMultiple(int count)
{
    QVector<QVector<Card>> boosters;
    for (int i = 0; i < count; ++i) {
        boosters.append(generate());
    }
    return boosters;
}

QVector<Card> Booster::fetchCardsByRarity(const QString& rarity)
{
    if (m_cardPools.contains(rarity)) {
        return m_cardPools[rarity];
    }

    QVector<Card> cards;
    m_cardPools[rarity] = cards;
    return cards;
}

Card Booster::pickRandom(const QVector<Card>& pool)
{
    if (pool.isEmpty()) {
        return Card();
    }

    int index = QRandomGenerator::global()->bounded(pool.size());
    return pool[index];
}
