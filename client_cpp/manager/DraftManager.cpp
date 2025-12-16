#include "DraftManager.h"
#include <QJsonDocument>
#include <QJsonArray>
#include <QJsonObject>
#include <QDebug>

DraftManager::DraftManager(SupabaseClient *client, QObject *parent)
    : QObject(parent), m_client(client)
{
}

DraftManager::~DraftManager()
{
}

void DraftManager::getDraft(const QString &draftId,
                           std::function<void(const Draft&, const QString&)> callback)
{
    QString filter = QString("id=eq.%1").arg(draftId);

    m_client->select("drafts", filter, [this, callback](bool success, const QJsonValue &data, const QString &error) {
        if (!success) {
            callback(Draft(), error);
            return;
        }

        QJsonArray array = data.toArray();
        if (array.isEmpty()) {
            callback(Draft(), "Draft not found");
            return;
        }

        Draft draft = parseDraft(array.first().toObject());
        callback(draft, "");
    });
}

void DraftManager::initializePacks(const QString &draftId,
                                   const QVector<Card> &availableCards,
                                   int playerCount,
                                   std::function<void(bool, const QString&)> callback)
{
    getDraft(draftId, [this, draftId, availableCards, playerCount, callback](const Draft& draft, const QString& error) {
        if (!draft.isValid()) {
            callback(false, error);
            return;
        }

        const int cardsPerPack = 15;
        QVector<QJsonObject> packsToInsert;

        for (int playerSeat = 0; playerSeat < playerCount; ++playerSeat) {
            for (int round = 1; round <= 3; ++round) {
                QJsonObject packData;
                packData["draft_id"] = draftId;
                packData["player_seat"] = playerSeat;
                packData["round_number"] = round;
                packData["current_owner_seat"] = playerSeat;

                QJsonArray cardsArray;
                for (int i = 0; i < cardsPerPack && i < availableCards.size(); ++i) {
                    const Card& card = availableCards[i + (playerSeat * cardsPerPack * 3) + ((round - 1) * cardsPerPack)];
                    cardsArray.append(QJsonDocument(card.toJson()).toJson(QJsonDocument::Compact));
                }
                packData["cards"] = cardsArray;

                packsToInsert.append(packData);
            }
        }

        QJsonDocument doc(QJsonArray::fromVariantList(
            QVariant(packsToInsert).toList()
        ));

        m_client->insert("draft_packs", doc.object(), [callback](bool success, const QJsonValue &data, const QString &error) {
            callback(success, error);
        });
    });
}

void DraftManager::getCurrentPack(const QString &draftId,
                                 int playerSeat,
                                 std::function<void(const DraftPack&, const QString&)> callback)
{
    getDraft(draftId, [this, playerSeat, callback](const Draft& draft, const QString& error) {
        if (!draft.isValid()) {
            callback(DraftPack(), error);
            return;
        }

        QString filter = QString("draft_id=eq.%1&current_owner_seat=eq.%2&round_number=eq.%3")
            .arg(draft.id())
            .arg(playerSeat)
            .arg(draft.currentRound());

        m_client->select("draft_packs", filter, [this, callback](bool success, const QJsonValue &data, const QString &error) {
            if (!success) {
                callback(DraftPack(), error);
                return;
            }

            QJsonArray array = data.toArray();
            if (array.isEmpty()) {
                callback(DraftPack(), "No pack available");
                return;
            }

            DraftPack pack = parsePack(array.first().toObject());
            callback(pack, "");
        });
    });
}

void DraftManager::pickCard(const QString &draftId,
                           int playerSeat,
                           const QString &cardId,
                           std::function<void(bool, const QString&)> callback)
{
    getCurrentPack(draftId, playerSeat, [this, draftId, playerSeat, cardId, callback](const DraftPack& pack, const QString& error) {
        if (!pack.isValid()) {
            callback(false, error);
            return;
        }

        QVector<Card> cards = pack.cards();
        QJsonArray updatedCards;
        Card pickedCard;

        for (const Card& card : cards) {
            if (card.id() == cardId) {
                pickedCard = card;
            } else {
                updatedCards.append(QJsonDocument(card.toJson()).toJson(QJsonDocument::Compact));
            }
        }

        if (!pickedCard.isValid()) {
            callback(false, "Card not found in pack");
            return;
        }

        QJsonObject packUpdate;
        packUpdate["cards"] = updatedCards;

        QString packFilter = QString("id=eq.%1").arg(pack.id());

        m_client->update("draft_packs", packFilter, packUpdate, [this, draftId, playerSeat, pickedCard, callback](bool success, const QJsonValue &data, const QString &error) {
            if (!success) {
                callback(false, error);
                return;
            }

            getPlayerPool(draftId, playerSeat, [this, pickedCard, callback](const PlayerPool& pool, const QString& error) {
                if (!pool.isValid()) {
                    callback(false, error);
                    return;
                }

                QVector<Card> poolCards = pool.cards();
                poolCards.append(pickedCard);

                QJsonArray cardsArray;
                for (const Card& card : poolCards) {
                    cardsArray.append(QJsonDocument(card.toJson()).toJson(QJsonDocument::Compact));
                }

                QJsonObject poolUpdate;
                poolUpdate["cards"] = cardsArray;

                QString poolFilter = QString("id=eq.%1").arg(pool.id());

                m_client->update("player_pools", poolFilter, poolUpdate, [callback](bool success, const QJsonValue &data, const QString &error) {
                    callback(success, error);
                });
            });
        });
    });
}

void DraftManager::getPlayerPool(const QString &draftId,
                                int playerSeat,
                                std::function<void(const PlayerPool&, const QString&)> callback)
{
    QString filter = QString("draft_id=eq.%1&player_seat=eq.%2")
        .arg(draftId)
        .arg(playerSeat);

    m_client->select("player_pools", filter, [this, draftId, playerSeat, callback](bool success, const QJsonValue &data, const QString &error) {
        if (!success) {
            callback(PlayerPool(), error);
            return;
        }

        QJsonArray array = data.toArray();
        if (array.isEmpty()) {
            QJsonObject poolData;
            poolData["draft_id"] = draftId;
            poolData["player_seat"] = playerSeat;
            poolData["cards"] = QJsonArray();

            m_client->insert("player_pools", poolData, [this, callback](bool success, const QJsonValue &data, const QString &error) {
                if (!success) {
                    callback(PlayerPool(), error);
                    return;
                }

                QJsonArray array = data.toArray();
                if (array.isEmpty()) {
                    callback(PlayerPool(), "Failed to create pool");
                    return;
                }

                PlayerPool pool = parsePool(array.first().toObject());
                callback(pool, "");
            });
            return;
        }

        PlayerPool pool = parsePool(array.first().toObject());
        callback(pool, "");
    });
}

void DraftManager::advanceRound(const QString &draftId,
                               std::function<void(bool, const QString&)> callback)
{
    getDraft(draftId, [this, draftId, callback](const Draft& draft, const QString& error) {
        if (!draft.isValid()) {
            callback(false, error);
            return;
        }

        Draft updatedDraft = draft;
        updatedDraft.advanceRound();

        QJsonObject updateData;
        updateData["current_round"] = updatedDraft.currentRound();
        updateData["current_pick"] = updatedDraft.currentPick();
        updateData["direction"] = updatedDraft.direction();

        QString filter = QString("id=eq.%1").arg(draftId);

        m_client->update("drafts", filter, updateData, [callback](bool success, const QJsonValue &data, const QString &error) {
            callback(success, error);
        });
    });
}

void DraftManager::completeDraft(const QString &draftId,
                                std::function<void(bool, const QString&)> callback)
{
    QJsonObject updateData;
    updateData["status"] = "completed";
    updateData["completed_at"] = QDateTime::currentDateTime().toString(Qt::ISODate);

    QString filter = QString("id=eq.%1").arg(draftId);

    m_client->update("drafts", filter, updateData, [callback](bool success, const QJsonValue &data, const QString &error) {
        callback(success, error);
    });
}

void DraftManager::rotatePacks(const QString &draftId,
                              const Draft &draft,
                              std::function<void(bool, const QString&)> callback)
{
    QString filter = QString("draft_id=eq.%1&round_number=eq.%2")
        .arg(draftId)
        .arg(draft.currentRound());

    m_client->select("draft_packs", filter, [this, draftId, draft, callback](bool success, const QJsonValue &data, const QString &error) {
        if (!success) {
            callback(false, error);
            return;
        }

        QVector<DraftPack> packs = parsePacks(data.toArray());
        callback(true, "");
    });
}

Draft DraftManager::parseDraft(const QJsonObject &data)
{
    QJsonDocument doc(data);
    Draft draft = Draft::fromJson(data);
    if (!draft.isValid()) {
        qWarning() << "Failed to parse draft from JSON";
    }
    return draft;
}

DraftPack DraftManager::parsePack(const QJsonObject &data)
{
    QJsonDocument doc(data);
    DraftPack pack = DraftPack::fromJson(data);
    if (!pack.isValid()) {
        qWarning() << "Failed to parse pack from JSON";
    }
    return pack;
}

PlayerPool DraftManager::parsePool(const QJsonObject &data)
{
    QJsonDocument doc(data);
    PlayerPool pool = PlayerPool::fromJson(data);
    if (!pool.isValid()) {
        qWarning() << "Failed to parse pool from JSON";
    }
    return pool;
}

QVector<DraftPack> DraftManager::parsePacks(const QJsonArray &data)
{
    QVector<DraftPack> packs;
    for (const QJsonValue &value : data) {
        DraftPack pack = parsePack(value.toObject());
        if (pack.isValid()) {
            packs.append(pack);
        }
    }
    return packs;
}
