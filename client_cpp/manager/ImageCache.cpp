#include "ImageCache.h"
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QDir>
#include <QFile>
#include <QCryptographicHash>
#include <QStandardPaths>
#include <QDebug>

ImageCache::ImageCache(QObject *parent)
    : QObject(parent)
    , m_networkManager(new QNetworkAccessManager(this))
{
    QString appDataPath = QStandardPaths::writableLocation(QStandardPaths::AppDataLocation);
    m_cacheDirectory = appDataPath + "/image_cache";

    QDir dir;
    if (!dir.exists(m_cacheDirectory)) {
        dir.mkpath(m_cacheDirectory);
    }
}

ImageCache::~ImageCache()
{
}

void ImageCache::setCacheDirectory(const QString &path)
{
    m_cacheDirectory = path;
    QDir dir;
    if (!dir.exists(m_cacheDirectory)) {
        dir.mkpath(m_cacheDirectory);
    }
}

QString ImageCache::getCacheFilePath(const QString &url) const
{
    QByteArray hash = QCryptographicHash::hash(url.toUtf8(), QCryptographicHash::Md5);
    QString filename = QString(hash.toHex()) + ".png";
    return m_cacheDirectory + "/" + filename;
}

bool ImageCache::loadFromDisk(const QString &url, QPixmap &pixmap)
{
    QString filePath = getCacheFilePath(url);
    if (QFile::exists(filePath)) {
        return pixmap.load(filePath);
    }
    return false;
}

bool ImageCache::saveToDisk(const QString &url, const QPixmap &pixmap)
{
    QString filePath = getCacheFilePath(url);
    return pixmap.save(filePath, "PNG");
}

bool ImageCache::hasImage(const QString &url) const
{
    return m_cache.contains(url);
}

QPixmap ImageCache::getImage(const QString &url) const
{
    return m_cache.value(url, QPixmap());
}

void ImageCache::loadImage(const QString &url,
                           std::function<void(const QPixmap&, const QString&)> callback)
{
    if (url.isEmpty()) {
        if (callback) callback(QPixmap(), "Empty URL");
        return;
    }

    if (m_cache.contains(url)) {
        if (callback) callback(m_cache[url], QString());
        emit imageLoaded(url, m_cache[url]);
        return;
    }

    QPixmap diskPixmap;
    if (loadFromDisk(url, diskPixmap)) {
        m_cache[url] = diskPixmap;
        if (callback) callback(diskPixmap, QString());
        emit imageLoaded(url, diskPixmap);
        return;
    }

    QNetworkRequest request(url);
    request.setAttribute(QNetworkRequest::CacheLoadControlAttribute, QNetworkRequest::PreferCache);
    QNetworkReply *reply = m_networkManager->get(request);

    m_pendingRequests[reply] = callback;

    connect(reply, &QNetworkReply::finished, this, &ImageCache::onImageDownloaded);
}

void ImageCache::preloadImages(const QStringList &urls)
{
    for (const QString &url : urls) {
        if (!url.isEmpty() && !m_cache.contains(url)) {
            loadImage(url, nullptr);
        }
    }
}

void ImageCache::clearCache()
{
    m_cache.clear();

    QDir dir(m_cacheDirectory);
    dir.removeRecursively();
    dir.mkpath(m_cacheDirectory);
}

void ImageCache::onImageDownloaded()
{
    QNetworkReply *reply = qobject_cast<QNetworkReply*>(sender());
    if (!reply) return;

    QString url = reply->request().url().toString();
    auto callback = m_pendingRequests.take(reply);

    if (reply->error() != QNetworkReply::NoError) {
        QString error = QString("Failed to download image: %1").arg(reply->errorString());
        qWarning() << error;
        if (callback) callback(QPixmap(), error);
        emit imageLoadFailed(url, error);
        reply->deleteLater();
        return;
    }

    QByteArray imageData = reply->readAll();
    QPixmap pixmap;
    if (!pixmap.loadFromData(imageData)) {
        QString error = "Failed to load image data";
        qWarning() << error;
        if (callback) callback(QPixmap(), error);
        emit imageLoadFailed(url, error);
        reply->deleteLater();
        return;
    }

    m_cache[url] = pixmap;
    saveToDisk(url, pixmap);

    if (callback) callback(pixmap, QString());
    emit imageLoaded(url, pixmap);

    reply->deleteLater();
}
