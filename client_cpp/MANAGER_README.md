# Basilic C++ Manager Layer

Cette couche implémente le client Supabase et les gestionnaires pour la communication avec la base de données.

## Architecture

### SupabaseClient
Client HTTP de base pour communiquer avec l'API REST de Supabase.

**Fonctionnalités:**
- Requêtes SELECT avec filtres
- INSERT de nouvelles données
- UPDATE de données existantes
- DELETE de lignes
- Appels RPC pour les fonctions Supabase

**Exemple:**
```cpp
SupabaseClient client;
client.initialize(url, apiKey);

client.select("cards", "*", "set_code=eq.DOM",
    [](const QJsonArray &data, const QString &error) {
        // Traiter les résultats
    });
```

### DatabaseManager
Gestionnaire pour charger les cartes et les sets depuis Supabase.

**Fonctionnalités:**
- Charger tous les sets
- Charger un set spécifique
- Charger les cartes d'un set
- Charger toutes les cartes
- Rechercher des cartes par nom
- Obtenir une carte par ID

**Exemple:**
```cpp
DatabaseManager dbManager(&client);

dbManager.loadAllSets([](const QVector<Set> &sets, const QString &error) {
    if (!error.isEmpty()) {
        qDebug() << "Erreur:" << error;
        return;
    }
    qDebug() << "Sets chargés:" << sets.size();
});
```

### LobbyManager
Gestionnaire pour les opérations de lobby (création, jointure, etc.).

**Fonctionnalités:**
- Créer un lobby
- Rejoindre un lobby
- Quitter un lobby
- Lister les lobbies disponibles
- Obtenir les détails d'un lobby
- Mettre à jour le statut d'un lobby
- Démarrer un draft

**Exemple:**
```cpp
LobbyManager lobbyManager(&client);

lobbyManager.createLobby("Mon Draft", "DOM", "Alice", 8,
    [](const Lobby &lobby, const QString &error) {
        if (!error.isEmpty()) {
            qDebug() << "Erreur:" << error;
            return;
        }
        qDebug() << "Lobby créé:" << lobby.getCode();
    });
```

### DraftManager
Gestionnaire pour la simulation de draft.

**Fonctionnalités:**
- Obtenir un draft
- Initialiser les packs
- Obtenir le pack actuel d'un joueur
- Faire un pick de carte
- Obtenir le pool d'un joueur
- Avancer de round
- Compléter un draft

**Exemple:**
```cpp
DraftManager draftManager(&client);

draftManager.pickCard(draftId, playerSeat, cardId,
    [](bool success, const QString &error) {
        if (!success) {
            qDebug() << "Erreur:" << error;
            return;
        }
        qDebug() << "Carte pickée avec succès";
    });
```

### ImageCache
Cache pour télécharger et stocker les images des cartes.

**Fonctionnalités:**
- Charger une image depuis une URL
- Précharger plusieurs images
- Cache en mémoire et sur disque
- Vérifier si une image est en cache
- Obtenir une image du cache
- Vider le cache

**Exemple:**
```cpp
ImageCache imageCache;

imageCache.loadImage(imageUrl, [](const QPixmap &pixmap, const QString &error) {
    if (!error.isEmpty()) {
        qDebug() << "Erreur:" << error;
        return;
    }
    // Afficher l'image
});
```

## Tests

Pour tester les managers:

### Windows
```bash
cd client_cpp
test_managers.bat
```

Ce script va:
1. Configurer CMake
2. Compiler test_managers
3. Exécuter les tests de connexion Supabase

## Dépendances

- Qt6 Core
- Qt6 Network
- Configuration .env avec credentials Supabase

## Prochaines étapes

1. ✅ Couche modèle (Card, Set, Lobby, Draft, etc.)
2. ✅ Couche manager (SupabaseClient, DatabaseManager, etc.)
3. ⭕ Interface utilisateur Qt (MainWindow.ui)
4. ⭕ Intégration UI avec les managers
5. ⭕ Fonctionnalité bibliothèque de cartes
6. ⭕ Fonctionnalité génération de boosters
7. ⭕ Système de lobby complet
8. ⭕ Interface de draft

## Notes

- Tous les callbacks sont asynchrones
- Les requêtes réseau utilisent QNetworkAccessManager de Qt
- Les erreurs sont retournées via les callbacks
- Le cache d'images utilise le répertoire AppData de l'utilisateur
