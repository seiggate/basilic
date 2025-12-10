#include "SupabaseClient.h"
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QUrlQuery>
#include <QDebug>

SupabaseClient::SupabaseClient(QObject *parent)
    : QObject(parent)
    , m_networkManager(new QNetworkAccessManager(this))
    , m_initialized(false)
{
}

SupabaseClient::~SupabaseClient()
{
}

bool SupabaseClient::initialize(const QString &url, const QString &anonKey)
{
    if (url.isEmpty() || anonKey.isEmpty()) {
        qWarning() << "SupabaseClient: Invalid URL or API key";
        return false;
    }

    m_baseUrl = url + "/rest/v1";
    m_apiKey = anonKey;
    m_initialized = true;

    qDebug() << "SupabaseClient initialized with URL:" << m_baseUrl;
    return true;
}

QNetworkRequest SupabaseClient::createRequest(const QString &endpoint) const
{
    QNetworkRequest request;
    request.setUrl(QUrl(m_baseUrl + endpoint));
    request.setRawHeader("apikey", m_apiKey.toUtf8());
    request.setRawHeader("Authorization", QString("Bearer %1").arg(m_apiKey).toUtf8());
    request.setRawHeader("Content-Type", "application/json");
    request.setRawHeader("Prefer", "return=representation");
    return request;
}

void SupabaseClient::select(const QString &table,
                            const QString &columns,
                            const QString &filter,
                            std::function<void(const QJsonArray&, const QString&)> callback)
{
    if (!m_initialized) {
        if (callback) callback(QJsonArray(), "Client not initialized");
        return;
    }

    QString endpoint = "/" + table + "?select=" + columns;
    if (!filter.isEmpty()) {
        endpoint += "&" + filter;
    }

    QNetworkRequest request = createRequest(endpoint);
    QNetworkReply *reply = m_networkManager->get(request);

    connect(reply, &QNetworkReply::finished, this, [this, reply, callback]() {
        handleReply(reply, [callback](const QByteArray &data, const QString &error) {
            if (!error.isEmpty()) {
                if (callback) callback(QJsonArray(), error);
                return;
            }

            QJsonDocument doc = QJsonDocument::fromJson(data);
            if (doc.isArray()) {
                if (callback) callback(doc.array(), QString());
            } else if (doc.isObject()) {
                QJsonArray arr;
                arr.append(doc.object());
                if (callback) callback(arr, QString());
            } else {
                if (callback) callback(QJsonArray(), "Invalid JSON response");
            }
        });
    });
}

void SupabaseClient::insert(const QString &table,
                            const QJsonObject &data,
                            std::function<void(const QJsonObject&, const QString&)> callback)
{
    if (!m_initialized) {
        if (callback) callback(QJsonObject(), "Client not initialized");
        return;
    }

    QString endpoint = "/" + table;
    QNetworkRequest request = createRequest(endpoint);

    QJsonDocument doc(data);
    QNetworkReply *reply = m_networkManager->post(request, doc.toJson());

    connect(reply, &QNetworkReply::finished, this, [this, reply, callback]() {
        handleReply(reply, [callback](const QByteArray &data, const QString &error) {
            if (!error.isEmpty()) {
                if (callback) callback(QJsonObject(), error);
                return;
            }

            QJsonDocument doc = QJsonDocument::fromJson(data);
            if (doc.isArray() && doc.array().size() > 0) {
                if (callback) callback(doc.array().first().toObject(), QString());
            } else if (doc.isObject()) {
                if (callback) callback(doc.object(), QString());
            } else {
                if (callback) callback(QJsonObject(), "Invalid JSON response");
            }
        });
    });
}

void SupabaseClient::update(const QString &table,
                            const QJsonObject &data,
                            const QString &filter,
                            std::function<void(const QJsonObject&, const QString&)> callback)
{
    if (!m_initialized) {
        if (callback) callback(QJsonObject(), "Client not initialized");
        return;
    }

    QString endpoint = "/" + table;
    if (!filter.isEmpty()) {
        endpoint += "?" + filter;
    }

    QNetworkRequest request = createRequest(endpoint);
    QJsonDocument doc(data);
    QNetworkReply *reply = m_networkManager->sendCustomRequest(request, "PATCH", doc.toJson());

    connect(reply, &QNetworkReply::finished, this, [this, reply, callback]() {
        handleReply(reply, [callback](const QByteArray &data, const QString &error) {
            if (!error.isEmpty()) {
                if (callback) callback(QJsonObject(), error);
                return;
            }

            QJsonDocument doc = QJsonDocument::fromJson(data);
            if (doc.isArray() && doc.array().size() > 0) {
                if (callback) callback(doc.array().first().toObject(), QString());
            } else if (doc.isObject()) {
                if (callback) callback(doc.object(), QString());
            } else {
                if (callback) callback(QJsonObject(), "Invalid JSON response");
            }
        });
    });
}

void SupabaseClient::deleteRow(const QString &table,
                               const QString &filter,
                               std::function<void(bool, const QString&)> callback)
{
    if (!m_initialized) {
        if (callback) callback(false, "Client not initialized");
        return;
    }

    QString endpoint = "/" + table;
    if (!filter.isEmpty()) {
        endpoint += "?" + filter;
    }

    QNetworkRequest request = createRequest(endpoint);
    QNetworkReply *reply = m_networkManager->deleteResource(request);

    connect(reply, &QNetworkReply::finished, this, [this, reply, callback]() {
        handleReply(reply, [callback](const QByteArray &data, const QString &error) {
            if (!error.isEmpty()) {
                if (callback) callback(false, error);
                return;
            }
            if (callback) callback(true, QString());
        });
    });
}

void SupabaseClient::rpc(const QString &functionName,
                         const QJsonObject &params,
                         std::function<void(const QJsonValue&, const QString&)> callback)
{
    if (!m_initialized) {
        if (callback) callback(QJsonValue(), "Client not initialized");
        return;
    }

    QString endpoint = "/rpc/" + functionName;
    QNetworkRequest request = createRequest(endpoint);

    QJsonDocument doc(params);
    QNetworkReply *reply = m_networkManager->post(request, doc.toJson());

    connect(reply, &QNetworkReply::finished, this, [this, reply, callback]() {
        handleReply(reply, [callback](const QByteArray &data, const QString &error) {
            if (!error.isEmpty()) {
                if (callback) callback(QJsonValue(), error);
                return;
            }

            QJsonDocument doc = QJsonDocument::fromJson(data);
            if (callback) callback(QJsonValue(doc.array()), QString());
        });
    });
}

void SupabaseClient::handleReply(QNetworkReply *reply,
                                 std::function<void(const QByteArray&, const QString&)> callback)
{
    reply->deleteLater();

    if (reply->error() != QNetworkReply::NoError) {
        QString error = QString("Network error: %1").arg(reply->errorString());
        qWarning() << error;
        if (callback) callback(QByteArray(), error);
        emit requestFinished(false, error);
        return;
    }

    QByteArray data = reply->readAll();
    if (callback) callback(data, QString());
    emit requestFinished(true, QString());
}

void SupabaseClient::onReplyFinished()
{
    QNetworkReply *reply = qobject_cast<QNetworkReply*>(sender());
    if (!reply) return;

    reply->deleteLater();
}
