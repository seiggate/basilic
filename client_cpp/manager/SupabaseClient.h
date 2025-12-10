#ifndef SUPABASECLIENT_H
#define SUPABASECLIENT_H

#include <QObject>
#include <QString>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <functional>

class SupabaseClient : public QObject
{
    Q_OBJECT

public:
    explicit SupabaseClient(QObject *parent = nullptr);
    ~SupabaseClient();

    bool initialize(const QString &url, const QString &anonKey);
    bool isInitialized() const { return m_initialized; }

    void select(const QString &table,
                const QString &columns = "*",
                const QString &filter = "",
                std::function<void(const QJsonArray&, const QString&)> callback = nullptr);

    void insert(const QString &table,
                const QJsonObject &data,
                std::function<void(const QJsonObject&, const QString&)> callback = nullptr);

    void update(const QString &table,
                const QJsonObject &data,
                const QString &filter,
                std::function<void(const QJsonObject&, const QString&)> callback = nullptr);

    void deleteRow(const QString &table,
                   const QString &filter,
                   std::function<void(bool, const QString&)> callback = nullptr);

    void rpc(const QString &functionName,
             const QJsonObject &params,
             std::function<void(const QJsonValue&, const QString&)> callback = nullptr);

signals:
    void requestFinished(bool success, const QString &error);

private slots:
    void onReplyFinished();

private:
    QNetworkAccessManager *m_networkManager;
    QString m_baseUrl;
    QString m_apiKey;
    bool m_initialized;

    QNetworkRequest createRequest(const QString &endpoint) const;
    void handleReply(QNetworkReply *reply,
                    std::function<void(const QByteArray&, const QString&)> callback);
};

#endif
