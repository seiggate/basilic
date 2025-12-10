#ifndef DRAFTMANAGER_H
#define DRAFTMANAGER_H

#include <QObject>
#include <QString>
#include <QVector>
#include <QMap>
#include <functional>
#include "SupabaseClient.h"
#include "Draft.h"
#include "DraftPack.h"
#include "PlayerPool.h"
#include "Card.h"

class DraftManager : public QObject
{
    Q_OBJECT

public:
    explicit DraftManager(SupabaseClient *client, QObject *parent = nullptr);
    ~DraftManager();

    void getDraft(const QString &draftId,
                  std::function<void(const Draft&, const QString&)> callback);

    void initializePacks(const QString &draftId,
                        const QVector<Card> &availableCards,
                        int playerCount,
                        std::function<void(bool, const QString&)> callback);

    void getCurrentPack(const QString &draftId,
                       int playerSeat,
                       std::function<void(const DraftPack&, const QString&)> callback);

    void pickCard(const QString &draftId,
                 int playerSeat,
                 const QString &cardId,
                 std::function<void(bool, const QString&)> callback);

    void getPlayerPool(const QString &draftId,
                      int playerSeat,
                      std::function<void(const PlayerPool&, const QString&)> callback);

    void advanceRound(const QString &draftId,
                     std::function<void(bool, const QString&)> callback);

    void completeDraft(const QString &draftId,
                      std::function<void(bool, const QString&)> callback);

signals:
    void draftUpdated(const Draft &draft);
    void packUpdated(const DraftPack &pack);
    void poolUpdated(const PlayerPool &pool);
    void error(const QString &message);

private:
    SupabaseClient *m_client;

    Draft parseDraft(const QJsonObject &data);
    DraftPack parsePack(const QJsonObject &data);
    PlayerPool parsePool(const QJsonObject &data);
    QVector<DraftPack> parsePacks(const QJsonArray &data);

    void rotatePacks(const QString &draftId,
                    const Draft &draft,
                    std::function<void(bool, const QString&)> callback);
};

#endif
