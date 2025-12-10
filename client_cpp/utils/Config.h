#ifndef CONFIG_H
#define CONFIG_H

#include <QString>
#include <QMap>

class Config
{
public:
    static Config* instance();

    bool loadEnvironment();

    QString supabaseUrl() const;
    QString supabaseAnonKey() const;

    QString get(const QString& key, const QString& defaultValue = "") const;

private:
    Config();
    ~Config() = default;

    Config(const Config&) = delete;
    Config& operator=(const Config&) = delete;

    static Config* s_instance;

    QMap<QString, QString> m_envVars;

    bool parseEnvFile(const QString& filePath);
};

#endif // CONFIG_H
