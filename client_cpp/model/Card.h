#ifndef CARD_H
#define CARD_H

#include <QString>
#include <QStringList>
#include <QJsonObject>
#include <QDateTime>

class Card
{
public:
    Card();
    Card(const QJsonObject& json);

    QString id() const { return m_id; }
    QString name() const { return m_name; }
    QString manaCost() const { return m_manaCost; }
    double cmc() const { return m_cmc; }
    QString typeLine() const { return m_typeLine; }
    QString oracleText() const { return m_oracleText; }
    QStringList colors() const { return m_colors; }
    QString rarity() const { return m_rarity; }
    QString setCode() const { return m_setCode; }
    QString collectorNumber() const { return m_collectorNumber; }
    QString imageUri() const { return m_imageUri; }
    QString imageUriSmall() const { return m_imageUriSmall; }
    QJsonObject prices() const { return m_prices; }

    void setId(const QString& id) { m_id = id; }
    void setName(const QString& name) { m_name = name; }
    void setManaCost(const QString& cost) { m_manaCost = cost; }
    void setCmc(double cmc) { m_cmc = cmc; }
    void setTypeLine(const QString& type) { m_typeLine = type; }
    void setOracleText(const QString& text) { m_oracleText = text; }
    void setColors(const QStringList& colors) { m_colors = colors; }
    void setRarity(const QString& rarity) { m_rarity = rarity; }
    void setSetCode(const QString& code) { m_setCode = code; }
    void setCollectorNumber(const QString& number) { m_collectorNumber = number; }
    void setImageUri(const QString& uri) { m_imageUri = uri; }
    void setImageUriSmall(const QString& uri) { m_imageUriSmall = uri; }
    void setPrices(const QJsonObject& prices) { m_prices = prices; }

    bool isMonochrome() const;
    bool containsColor(const QString& color) const;
    bool isBasicLand() const;

    QJsonObject toJson() const;
    static Card fromJson(const QJsonObject& json);

    bool isValid() const { return !m_id.isEmpty() && !m_name.isEmpty(); }

private:
    QString m_id;
    QString m_name;
    QString m_manaCost;
    double m_cmc;
    QString m_typeLine;
    QString m_oracleText;
    QStringList m_colors;
    QString m_rarity;
    QString m_setCode;
    QString m_collectorNumber;
    QString m_imageUri;
    QString m_imageUriSmall;
    QJsonObject m_prices;
};

#endif // CARD_H
