#include <QCoreApplication>
#include <QDebug>
#include <QTimer>
#include "utils/Config.h"
#include "manager/SupabaseClient.h"
#include "manager/DatabaseManager.h"
#include "manager/LobbyManager.h"

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
            qDebug() << "First set:" << firstSet.name() << "(" << firstSet.code() << ")";
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
            qDebug() << "  -" << lobby.name() << "(" << lobby.code() << ")"
                     << lobby.currentPlayerCount() << "/" << lobby.maxPlayers() << "players";
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

    Config* config = Config::instance();
    if (!config->loadEnvironment()) {
        qCritical() << "Failed to load configuration";
        return 1;
    }

    qDebug() << "Configuration loaded:";
    qDebug() << "  Supabase URL:" << config->supabaseUrl();
    qDebug() << "  API Key length:" << config->supabaseAnonKey().length() << "chars";

    SupabaseClient client;
    if (!client.initialize(config->supabaseUrl(), config->supabaseAnonKey())) {
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
