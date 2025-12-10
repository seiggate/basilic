#ifndef SET_H
#define SET_H

#include <QString>
#include <QDate>
#include <QJsonObject>
#include <QDateTime>

class Set
{
public:
    Set();
    Set(const QString& code, const QString& name);
    Set(const QJsonObject& json);

    QString code() const { return m_code; }
    QString name() const { return m_name; }
    QDate releaseDate() const { return m_releaseDate; }
    int cardCount() const { return m_cardCount; }
    QString iconUri() const { return m_iconUri; }
    QDateTime createdAt() const { return m_createdAt; }

    void setCode(const QString& code) { m_code = code; }
    void setName(const QString& name) { m_name = name; }
    void setReleaseDate(const QDate& date) { m_releaseDate = date; }
    void setCardCount(int count) { m_cardCount = count; }
    void setIconUri(const QString& uri) { m_iconUri = uri; }
    void setCreatedAt(const QDateTime& time) { m_createdAt = time; }

    QJsonObject toJson() const;
    static Set fromJson(const QJsonObject& json);

    bool isValid() const { return !m_code.isEmpty() && !m_name.isEmpty(); }

private:
    QString m_code;
    QString m_name;
    QDate m_releaseDate;
    int m_cardCount;
    QString m_iconUri;
    QDateTime m_createdAt;
};

#endif // SET_H
