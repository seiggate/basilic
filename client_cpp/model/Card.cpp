#include "Card.h"
#include <QJsonArray>

Card::Card()
    : m_cmc(0.0)
{
}

Card::Card(const QJsonObject& json)
    : m_cmc(0.0)
{
    *this = fromJson(json);
}

bool Card::isMonochrome() const
{
    return m_colors.size() == 1;
}

bool Card::containsColor(const QString& color) const
{
    return m_colors.contains(color);
}

bool Card::isBasicLand() const
{
    return m_typeLine.contains("Basic Land", Qt::CaseInsensitive);
}

QJsonObject Card::toJson() const
{
    QJsonObject json;
    json["id"] = m_id;
    json["name"] = m_name;
    json["mana_cost"] = m_manaCost;
    json["cmc"] = m_cmc;
    json["type_line"] = m_typeLine;
    json["oracle_text"] = m_oracleText;

    QJsonArray colorsArray;
    for (const QString& color : m_colors) {
        colorsArray.append(color);
    }
    json["colors"] = colorsArray;

    json["rarity"] = m_rarity;
    json["set_code"] = m_setCode;
    json["collector_number"] = m_collectorNumber;
    json["image_uri"] = m_imageUri;
    json["image_uri_small"] = m_imageUriSmall;
    json["prices"] = m_prices;

    return json;
}

Card Card::fromJson(const QJsonObject& json)
{
    Card card;
    card.m_id = json["id"].toString();
    card.m_name = json["name"].toString();
    card.m_manaCost = json["mana_cost"].toString();
    card.m_cmc = json["cmc"].toDouble();
    card.m_typeLine = json["type_line"].toString();
    card.m_oracleText = json["oracle_text"].toString();

    QJsonArray colorsArray = json["colors"].toArray();
    for (const QJsonValue& value : colorsArray) {
        card.m_colors.append(value.toString());
    }

    card.m_rarity = json["rarity"].toString();
    card.m_setCode = json["set_code"].toString();
    card.m_collectorNumber = json["collector_number"].toString();
    card.m_imageUri = json["image_uri"].toString();
    card.m_imageUriSmall = json["image_uri_small"].toString();
    card.m_prices = json["prices"].toObject();

    return card;
}
