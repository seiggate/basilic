#include "Config.h"
#include <QFile>
#include <QTextStream>
#include <QDir>
#include <QCoreApplication>
#include <QDebug>

Config* Config::s_instance = nullptr;

Config::Config()
{
}

Config* Config::instance()
{
    if (!s_instance) {
        s_instance = new Config();
    }
    return s_instance;
}

bool Config::loadEnvironment()
{
    QStringList possiblePaths = {
        QCoreApplication::applicationDirPath() + "/.env",
        QDir::currentPath() + "/.env",
        QDir::currentPath() + "/../.env"
    };

    for (const QString& path : possiblePaths) {
        if (QFile::exists(path)) {
            qDebug() << "Found .env file at:" << path;
            return parseEnvFile(path);
        }
    }

    qWarning() << "No .env file found in any of these locations:";
    for (const QString& path : possiblePaths) {
        qWarning() << "  -" << path;
    }

    return false;
}

bool Config::parseEnvFile(const QString& filePath)
{
    QFile file(filePath);
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qWarning() << "Failed to open .env file:" << filePath;
        return false;
    }

    QTextStream in(&file);
    int lineNumber = 0;

    while (!in.atEnd()) {
        lineNumber++;
        QString line = in.readLine().trimmed();

        if (line.isEmpty() || line.startsWith('#')) {
            continue;
        }

        int equalsIndex = line.indexOf('=');
        if (equalsIndex == -1) {
            qWarning() << "Invalid line in .env (line" << lineNumber << "):" << line;
            continue;
        }

        QString key = line.left(equalsIndex).trimmed();
        QString value = line.mid(equalsIndex + 1).trimmed();

        if (value.startsWith('"') && value.endsWith('"')) {
            value = value.mid(1, value.length() - 2);
        } else if (value.startsWith('\'') && value.endsWith('\'')) {
            value = value.mid(1, value.length() - 2);
        }

        m_envVars[key] = value;
    }

    file.close();

    qDebug() << "Loaded" << m_envVars.size() << "environment variables";

    if (!m_envVars.contains("SUPABASE_URL") || !m_envVars.contains("SUPABASE_ANON_KEY")) {
        qWarning() << "Missing required Supabase credentials in .env file";
        return false;
    }

    return true;
}

QString Config::supabaseUrl() const
{
    return m_envVars.value("SUPABASE_URL", "");
}

QString Config::supabaseAnonKey() const
{
    return m_envVars.value("SUPABASE_ANON_KEY", "");
}

QString Config::get(const QString& key, const QString& defaultValue) const
{
    return m_envVars.value(key, defaultValue);
}
