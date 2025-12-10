#ifndef DATABASEMANAGER_H
#define DATABASEMANAGER_H

#include <QObject>
#include <QString>
#include <QVector>
#include <functional>
#include "SupabaseClient.h"
#include "Card.h"
#include "Set.h"

class DatabaseManager : public QObject
{
    Q_OBJECT

public:
    explicit DatabaseManager(SupabaseClient *client, QObject *parent = nullptr);
    ~DatabaseManager();

    void loadAllSets(std::function<void(const QVector<Set>&, const QString&)> callback);
    void loadSet(const QString &setCode, std::function<void(const Set&, const QString&)> callback);

    void loadCardsFromSet(const QString &setCode,
                          std::function<void(const QVector<Card>&, const QString&)> callback);

    void loadAllCards(std::function<void(const QVector<Card>&, const QString&)> callback);

    void searchCards(const QString &query,
                     std::function<void(const QVector<Card>&, const QString&)> callback);

    void getCardById(const QString &cardId,
                     std::function<void(const Card&, const QString&)> callback);

signals:
    void setsLoaded(const QVector<Set> &sets);
    void cardsLoaded(const QVector<Card> &cards);
    void error(const QString &message);

private:
    SupabaseClient *m_client;

    QVector<Set> parseSets(const QJsonArray &data);
    QVector<Card> parseCards(const QJsonArray &data);
    Set parseSet(const QJsonObject &data);
    Card parseCard(const QJsonObject &data);
};

#endif
