#ifndef IMAGECACHE_H
#define IMAGECACHE_H

#include <QObject>
#include <QPixmap>
#include <QString>
#include <QMap>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <functional>

class ImageCache : public QObject
{
    Q_OBJECT

public:
    explicit ImageCache(QObject *parent = nullptr);
    ~ImageCache();

    void loadImage(const QString &url,
                   std::function<void(const QPixmap&, const QString&)> callback);

    void preloadImages(const QStringList &urls);

    bool hasImage(const QString &url) const;
    QPixmap getImage(const QString &url) const;

    void clearCache();
    void setCacheDirectory(const QString &path);

signals:
    void imageLoaded(const QString &url, const QPixmap &pixmap);
    void imageLoadFailed(const QString &url, const QString &error);

private slots:
    void onImageDownloaded();

private:
    QNetworkAccessManager *m_networkManager;
    QMap<QString, QPixmap> m_cache;
    QMap<QNetworkReply*, std::function<void(const QPixmap&, const QString&)>> m_pendingRequests;
    QString m_cacheDirectory;

    QString getCacheFilePath(const QString &url) const;
    bool loadFromDisk(const QString &url, QPixmap &pixmap);
    bool saveToDisk(const QString &url, const QPixmap &pixmap);
};

#endif
