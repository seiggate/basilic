#include "DraftManager.h"
#include "Booster.h"
#include <QJsonArray>
#include <QJsonObject>
#include <QDebug>
#include <QRandomGenerator>

DraftManager::DraftManager(SupabaseClient *client, QObject *parent)
    : QObject(parent)
    , m_client(client)
{
}

DraftManager::~DraftManager()
{
}

void DraftManager::getDraft(const QString &draftId,
                            std::function<void(const Draft&, const QString&)> callback)
{
    if (!m_client || !m_client->isInitialized()) {
        if (callback) callback(Draft(), "Database client not initialized");
        return;
    }

    QString filter = QString("id=eq.%1").arg(draftId);
    m_client->select("drafts", "*", filter,
        [this, callback](const QJsonArray &data, const QString &error) {
            if (!error.isEmpty()) {
                if (callback) callback(Draft(), error);
                return;
            }

            if (data.isEmpty()) {
                if (callback) callback(Draft(), "Draft not found");
                return;
            }

            Draft draft = parseDraft(data.first().toObject());
            if (callback) callback(draft, QString());
        });
}

void DraftManager::initializePacks(const QString &draftId,
                                   const QVector<Card> &availableCards,
                                   int playerCount,
                                   std::function<void(bool, const QString&)> callback)
{
    if (!m_client || !m_client->isInitialized()) {
        if (callback) callback(false, "Database client not initialized");
        return;
    }

    if (availableCards.isEmpty()) {
        if (callback) callback(false, "No cards available for draft");
        return;
    }

    const int packsPerPlayer = 3;
    const int cardsPerPack = 14;

    for (int round = 1; round <= packsPerPlayer; ++round) {
        for (int seat = 0; seat < playerCount; ++seat) {
            QJsonArray packCards;

            for (int i = 0; i < cardsPerPack && !availableCards.isEmpty(); ++i) {
                int randomIndex = QRandomGenerator::global()->bounded(availableCards.size());
                const Card &card = availableCards[randomIndex];

                QJsonObject cardObj = QJsonDocument::fromJson(card.toJson()).object();
                packCards.append(cardObj);
            }

            QJsonObject packData;
            packData["draft_id"] = draftId;
            packData["player_seat"] = seat;
            packData["round"] = round;
            packData["cards"] = packCards;

            m_client->insert("draft_packs", packData,
                [](const QJsonObject &data, const QString &error) {
                    if (!error.isEmpty()) {
                        qWarning() << "Failed to create pack:" << error;
                    }
                });
        }
    }

    for (int seat = 0; seat < playerCount; ++seat) {
        QJsonObject poolData;
        poolData["draft_id"] = draftId;
        poolData["player_seat"] = seat;
        poolData["cards"] = QJsonArray();

        m_client->insert("player_pools", poolData,
            [](const QJsonObject &data, const QString &error) {
                if (!error.isEmpty()) {
                    qWarning() << "Failed to create pool:" << error;
                }
            });
    }

    if (callback) callback(true, QString());
}

void DraftManager::getCurrentPack(const QString &draftId,
                                  int playerSeat,
                                  std::function<void(const DraftPack&, const QString&)> callback)
{
    if (!m_client || !m_client->isInitialized()) {
        if (callback) callback(DraftPack(), "Database client not initialized");
        return;
    }

    getDraft(draftId, [this, playerSeat, callback](const Draft &draft, const QString &error) {
        if (!error.isEmpty()) {
            if (callback) callback(DraftPack(), error);
            return;
        }

        QString filter = QString("draft_id=eq.%1&player_seat=eq.%2&round=eq.%3")
            .arg(draft.getId())
            .arg(playerSeat)
            .arg(draft.getCurrentRound());

        this->m_client->select("draft_packs", "*", filter,
            [this, callback](const QJsonArray &data, const QString &error) {
                if (!error.isEmpty()) {
                    if (callback) callback(DraftPack(), error);
                    return;
                }

                if (data.isEmpty()) {
                    if (callback) callback(DraftPack(), "Pack not found");
                    return;
                }

                DraftPack pack = parsePack(data.first().toObject());
                if (callback) callback(pack, QString());
            });
    });
}

void DraftManager::pickCard(const QString &draftId,
                            int playerSeat,
                            const QString &cardId,
                            std::function<void(bool, const QString&)> callback)
{
    if (!m_client || !m_client->isInitialized()) {
        if (callback) callback(false, "Database client not initialized");
        return;
    }

    getCurrentPack(draftId, playerSeat, [this, draftId, playerSeat, cardId, callback]
        (const DraftPack &pack, const QString &error) {
            if (!error.isEmpty()) {
                if (callback) callback(false, error);
                return;
            }

            QVector<Card> cards = pack.getCards();
            Card pickedCard;
            QJsonArray remainingCards;

            for (const Card &card : cards) {
                if (card.getId() == cardId) {
                    pickedCard = card;
                } else {
                    QJsonObject cardObj = QJsonDocument::fromJson(card.toJson()).object();
                    remainingCards.append(cardObj);
                }
            }

            if (!pickedCard.isValid()) {
                if (callback) callback(false, "Card not found in pack");
                return;
            }

            QJsonObject updateData;
            updateData["cards"] = remainingCards;

            QString packFilter = QString("id=eq.%1").arg(pack.getId());
            this->m_client->update("draft_packs", updateData, packFilter,
                [this, draftId, playerSeat, pickedCard, callback]
                (const QJsonObject &data, const QString &updateError) {
                    if (!updateError.isEmpty()) {
                        if (callback) callback(false, updateError);
                        return;
                    }

                    this->getPlayerPool(draftId, playerSeat,
                        [this, pickedCard, callback](const PlayerPool &pool, const QString &poolError) {
                            if (!poolError.isEmpty()) {
                                if (callback) callback(false, poolError);
                                return;
                            }

                            QVector<Card> poolCards = pool.getCards();
                            poolCards.append(pickedCard);

                            QJsonArray cardsArray;
                            for (const Card &card : poolCards) {
                                QJsonObject cardObj = QJsonDocument::fromJson(card.toJson()).object();
                                cardsArray.append(cardObj);
                            }

                            QJsonObject poolUpdate;
                            poolUpdate["cards"] = cardsArray;

                            QString poolFilter = QString("id=eq.%1").arg(pool.getId());
                            this->m_client->update("player_pools", poolUpdate, poolFilter,
                                [callback](const QJsonObject &poolData, const QString &poolUpdateError) {
                                    if (!poolUpdateError.isEmpty()) {
                                        if (callback) callback(false, poolUpdateError);
                                        return;
                                    }
                                    if (callback) callback(true, QString());
                                });
                        });
                });
        });
}

void DraftManager::getPlayerPool(const QString &draftId,
                                 int playerSeat,
                                 std::function<void(const PlayerPool&, const QString&)> callback)
{
    if (!m_client || !m_client->isInitialized()) {
        if (callback) callback(PlayerPool(), "Database client not initialized");
        return;
    }

    QString filter = QString("draft_id=eq.%1&player_seat=eq.%2").arg(draftId).arg(playerSeat);
    m_client->select("player_pools", "*", filter,
        [this, callback](const QJsonArray &data, const QString &error) {
            if (!error.isEmpty()) {
                if (callback) callback(PlayerPool(), error);
                return;
            }

            if (data.isEmpty()) {
                if (callback) callback(PlayerPool(), "Pool not found");
                return;
            }

            PlayerPool pool = parsePool(data.first().toObject());
            if (callback) callback(pool, QString());
        });
}

void DraftManager::advanceRound(const QString &draftId,
                                std::function<void(bool, const QString&)> callback)
{
    if (!m_client || !m_client->isInitialized()) {
        if (callback) callback(false, "Database client not initialized");
        return;
    }

    getDraft(draftId, [this, draftId, callback](const Draft &draft, const QString &error) {
        if (!error.isEmpty()) {
            if (callback) callback(false, error);
            return;
        }

        Draft updatedDraft = draft;
        updatedDraft.advanceRound();

        QJsonObject updateData;
        updateData["current_round"] = updatedDraft.getCurrentRound();
        updateData["current_pick"] = updatedDraft.getCurrentPick();
        updateData["direction"] = updatedDraft.getDirection();

        QString filter = QString("id=eq.%1").arg(draftId);
        this->m_client->update("drafts", updateData, filter,
            [callback](const QJsonObject &data, const QString &updateError) {
                if (!updateError.isEmpty()) {
                    if (callback) callback(false, updateError);
                    return;
                }
                if (callback) callback(true, QString());
            });
    });
}

void DraftManager::completeDraft(const QString &draftId,
                                 std::function<void(bool, const QString&)> callback)
{
    if (!m_client || !m_client->isInitialized()) {
        if (callback) callback(false, "Database client not initialized");
        return;
    }

    QJsonObject updateData;
    updateData["status"] = "completed";

    QString filter = QString("id=eq.%1").arg(draftId);
    m_client->update("drafts", updateData, filter,
        [callback](const QJsonObject &data, const QString &error) {
            if (!error.isEmpty()) {
                if (callback) callback(false, error);
                return;
            }
            if (callback) callback(true, QString());
        });
}

Draft DraftManager::parseDraft(const QJsonObject &data)
{
    Draft draft;

    QJsonDocument doc(data);
    if (!draft.fromJson(doc.toJson())) {
        qWarning() << "Failed to parse draft:" << data;
    }

    return draft;
}

DraftPack DraftManager::parsePack(const QJsonObject &data)
{
    DraftPack pack;

    QJsonDocument doc(data);
    if (!pack.fromJson(doc.toJson())) {
        qWarning() << "Failed to parse pack:" << data;
    }

    return pack;
}

PlayerPool DraftManager::parsePool(const QJsonObject &data)
{
    PlayerPool pool;

    QJsonDocument doc(data);
    if (!pool.fromJson(doc.toJson())) {
        qWarning() << "Failed to parse pool:" << data;
    }

    return pool;
}

QVector<DraftPack> DraftManager::parsePacks(const QJsonArray &data)
{
    QVector<DraftPack> packs;
    for (const QJsonValue &value : data) {
        if (value.isObject()) {
            DraftPack pack = parsePack(value.toObject());
            packs.append(pack);
        }
    }
    return packs;
}
