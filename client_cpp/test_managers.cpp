#include <QCoreApplication>
#include <QDebug>
#include <QTimer>
#include "Config.h"
#include "SupabaseClient.h"
#include "DatabaseManager.h"
#include "LobbyManager.h"

void testSupabaseConnection(SupabaseClient *client)
{
    qDebug() << "\n=== Test Supabase Connection ===";
    qDebug() << "Client initialized:" << client->isInitialized();
}

void testDatabaseManager(DatabaseManager *dbManager)
{
    qDebug() << "\n=== Test DatabaseManager ===";

    dbManager->loadAllSets([](const QVector<Set> &sets, const QString &error) {
        if (!error.isEmpty()) {
            qDebug() << "Error loading sets:" << error;
            return;
        }
        qDebug() << "Loaded" << sets.size() << "sets";
        if (!sets.isEmpty()) {
            const Set &firstSet = sets.first();
            qDebug() << "First set:" << firstSet.getName() << "(" << firstSet.getCode() << ")";
        }
    });

    QTimer::singleShot(2000, []() {
        qDebug() << "Database test completed";
    });
}

void testLobbyManager(LobbyManager *lobbyManager)
{
    qDebug() << "\n=== Test LobbyManager ===";

    lobbyManager->getLobbies("waiting", [](const QVector<Lobby> &lobbies, const QString &error) {
        if (!error.isEmpty()) {
            qDebug() << "Error loading lobbies:" << error;
            return;
        }
        qDebug() << "Found" << lobbies.size() << "waiting lobbies";
        for (const Lobby &lobby : lobbies) {
            qDebug() << "  -" << lobby.getName() << "(" << lobby.getCode() << ")"
                     << lobby.getPlayerCount() << "/" << lobby.getMaxPlayers() << "players";
        }
    });

    QTimer::singleShot(3000, []() {
        qDebug() << "Lobby test completed";
    });
}

int main(int argc, char *argv[])
{
    QCoreApplication app(argc, argv);

    qDebug() << "==================================";
    qDebug() << "Testing Basilic C++ Managers";
    qDebug() << "==================================\n";

    Config config;
    if (!config.load()) {
        qCritical() << "Failed to load configuration";
        return 1;
    }

    qDebug() << "Configuration loaded:";
    qDebug() << "  Supabase URL:" << config.getSupabaseUrl();
    qDebug() << "  API Key length:" << config.getSupabaseKey().length() << "chars";

    SupabaseClient client;
    if (!client.initialize(config.getSupabaseUrl(), config.getSupabaseKey())) {
        qCritical() << "Failed to initialize Supabase client";
        return 1;
    }

    testSupabaseConnection(&client);

    DatabaseManager dbManager(&client);
    LobbyManager lobbyManager(&client);

    testDatabaseManager(&dbManager);
    testLobbyManager(&lobbyManager);

    QTimer::singleShot(5000, &app, &QCoreApplication::quit);

    qDebug() << "\nRunning tests... (will exit in 5 seconds)\n";

    return app.exec();
}
