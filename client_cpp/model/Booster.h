#ifndef BOOSTER_H
#define BOOSTER_H

#include "Card.h"
#include <QVector>
#include <QMap>
#include <QString>

class Booster
{
public:
    explicit Booster(const QString& setCode);

    QVector<Card> generate();
    QVector<QVector<Card>> generateMultiple(int count);

    QString setCode() const { return m_setCode; }
    void setSetCode(const QString& code) { m_setCode = code; }

    static constexpr int COMMONS = 10;
    static constexpr int UNCOMMONS = 3;
    static constexpr int RARES = 1;
    static constexpr double MYTHIC_RATE = 0.125;

private:
    QString m_setCode;
    QMap<QString, QVector<Card>> m_cardPools;

    QVector<Card> fetchCardsByRarity(const QString& rarity);
    Card pickRandom(const QVector<Card>& pool);
};

#endif // BOOSTER_H
