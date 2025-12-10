#include "Set.h"

Set::Set()
    : m_cardCount(0)
{
}

Set::Set(const QString& code, const QString& name)
    : m_code(code)
    , m_name(name)
    , m_cardCount(0)
{
}

Set::Set(const QJsonObject& json)
    : m_cardCount(0)
{
    *this = fromJson(json);
}

QJsonObject Set::toJson() const
{
    QJsonObject json;
    json["code"] = m_code;
    json["name"] = m_name;
    json["release_date"] = m_releaseDate.toString(Qt::ISODate);
    json["card_count"] = m_cardCount;
    json["icon_uri"] = m_iconUri;
    json["created_at"] = m_createdAt.toString(Qt::ISODate);
    return json;
}

Set Set::fromJson(const QJsonObject& json)
{
    Set set;
    set.m_code = json["code"].toString();
    set.m_name = json["name"].toString();
    set.m_releaseDate = QDate::fromString(json["release_date"].toString(), Qt::ISODate);
    set.m_cardCount = json["card_count"].toInt();
    set.m_iconUri = json["icon_uri"].toString();
    set.m_createdAt = QDateTime::fromString(json["created_at"].toString(), Qt::ISODate);
    return set;
}
