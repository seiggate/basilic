#include "DatabaseManager.h"
#include <QJsonArray>
#include <QJsonObject>
#include <QDebug>

DatabaseManager::DatabaseManager(SupabaseClient *client, QObject *parent)
    : QObject(parent)
    , m_client(client)
{
}

DatabaseManager::~DatabaseManager()
{
}

void DatabaseManager::loadAllSets(std::function<void(const QVector<Set>&, const QString&)> callback)
{
    if (!m_client || !m_client->isInitialized()) {
        if (callback) callback(QVector<Set>(), "Database client not initialized");
        emit error("Database client not initialized");
        return;
    }

    m_client->select("sets", "*", "order=release_date.desc",
        [this, callback](const QJsonArray &data, const QString &error) {
            if (!error.isEmpty()) {
                if (callback) callback(QVector<Set>(), error);
                emit this->error(error);
                return;
            }

            QVector<Set> sets = parseSets(data);
            if (callback) callback(sets, QString());
            emit setsLoaded(sets);
        });
}

void DatabaseManager::loadSet(const QString &setCode, std::function<void(const Set&, const QString&)> callback)
{
    if (!m_client || !m_client->isInitialized()) {
        if (callback) callback(Set(), "Database client not initialized");
        return;
    }

    QString filter = QString("code=eq.%1").arg(setCode);
    m_client->select("sets", "*", filter,
        [this, callback](const QJsonArray &data, const QString &error) {
            if (!error.isEmpty()) {
                if (callback) callback(Set(), error);
                return;
            }

            if (data.isEmpty()) {
                if (callback) callback(Set(), "Set not found");
                return;
            }

            Set set = parseSet(data.first().toObject());
            if (callback) callback(set, QString());
        });
}

void DatabaseManager::loadCardsFromSet(const QString &setCode,
                                       std::function<void(const QVector<Card>&, const QString&)> callback)
{
    if (!m_client || !m_client->isInitialized()) {
        if (callback) callback(QVector<Card>(), "Database client not initialized");
        return;
    }

    QString filter = QString("set_code=eq.%1").arg(setCode);
    m_client->select("cards", "*", filter,
        [this, callback](const QJsonArray &data, const QString &error) {
            if (!error.isEmpty()) {
                if (callback) callback(QVector<Card>(), error);
                emit this->error(error);
                return;
            }

            QVector<Card> cards = parseCards(data);
            if (callback) callback(cards, QString());
            emit cardsLoaded(cards);
        });
}

void DatabaseManager::loadAllCards(std::function<void(const QVector<Card>&, const QString&)> callback)
{
    if (!m_client || !m_client->isInitialized()) {
        if (callback) callback(QVector<Card>(), "Database client not initialized");
        return;
    }

    m_client->select("cards", "*", "limit=10000",
        [this, callback](const QJsonArray &data, const QString &error) {
            if (!error.isEmpty()) {
                if (callback) callback(QVector<Card>(), error);
                emit this->error(error);
                return;
            }

            QVector<Card> cards = parseCards(data);
            if (callback) callback(cards, QString());
            emit cardsLoaded(cards);
        });
}

void DatabaseManager::searchCards(const QString &query,
                                  std::function<void(const QVector<Card>&, const QString&)> callback)
{
    if (!m_client || !m_client->isInitialized()) {
        if (callback) callback(QVector<Card>(), "Database client not initialized");
        return;
    }

    QString filter = QString("name=ilike.*%1*").arg(query);
    m_client->select("cards", "*", filter,
        [this, callback](const QJsonArray &data, const QString &error) {
            if (!error.isEmpty()) {
                if (callback) callback(QVector<Card>(), error);
                return;
            }

            QVector<Card> cards = parseCards(data);
            if (callback) callback(cards, QString());
        });
}

void DatabaseManager::getCardById(const QString &cardId,
                                  std::function<void(const Card&, const QString&)> callback)
{
    if (!m_client || !m_client->isInitialized()) {
        if (callback) callback(Card(), "Database client not initialized");
        return;
    }

    QString filter = QString("id=eq.%1").arg(cardId);
    m_client->select("cards", "*", filter,
        [this, callback](const QJsonArray &data, const QString &error) {
            if (!error.isEmpty()) {
                if (callback) callback(Card(), error);
                return;
            }

            if (data.isEmpty()) {
                if (callback) callback(Card(), "Card not found");
                return;
            }

            Card card = parseCard(data.first().toObject());
            if (callback) callback(card, QString());
        });
}

QVector<Set> DatabaseManager::parseSets(const QJsonArray &data)
{
    QVector<Set> sets;
    for (const QJsonValue &value : data) {
        if (value.isObject()) {
            Set set = parseSet(value.toObject());
            if (set.isValid()) {
                sets.append(set);
            }
        }
    }
    return sets;
}

QVector<Card> DatabaseManager::parseCards(const QJsonArray &data)
{
    QVector<Card> cards;
    for (const QJsonValue &value : data) {
        if (value.isObject()) {
            Card card = parseCard(value.toObject());
            if (card.isValid()) {
                cards.append(card);
            }
        }
    }
    return cards;
}

Set DatabaseManager::parseSet(const QJsonObject &data)
{
    Set set;

    QJsonDocument doc(data);
    if (!set.fromJson(doc.toJson())) {
        qWarning() << "Failed to parse set:" << data;
    }

    return set;
}

Card DatabaseManager::parseCard(const QJsonObject &data)
{
    Card card;

    QJsonDocument doc(data);
    if (!card.fromJson(doc.toJson())) {
        qWarning() << "Failed to parse card:" << data;
    }

    return card;
}
