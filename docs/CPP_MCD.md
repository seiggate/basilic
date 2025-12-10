# Modèle Conceptuel de Données - Basilic C++/Qt

## 📋 Vue d'ensemble

Architecture client C++/Qt avec backend Supabase pour un client de draft Magic: The Gathering.

---

## 🗂️ Structure des Classes C++

### 1️⃣ Couche Modèle (Model Layer)

#### **Card** - Représentation d'une carte Magic
```cpp
class Card {
private:
    QString m_id;              // UUID Supabase
    QString m_name;            // Nom de la carte
    QString m_manaCost;        // Coût de mana (ex: "{2}{U}{U}")
    double m_cmc;              // Converted mana cost
    QString m_typeLine;        // Type (ex: "Creature - Dragon")
    QString m_oracleText;      // Texte de la carte
    QStringList m_colors;      // ["U", "R"]
    QString m_rarity;          // common/uncommon/rare/mythic
    QString m_setCode;         // Code de l'extension (ex: "blb")
    QString m_collectorNumber; // Numéro collectionneur
    QString m_imageUri;        // URL image normale
    QString m_imageUriSmall;   // URL image petite
    QJsonObject m_prices;      // Prix (format JSON)

public:
    // Constructeurs
    Card();
    Card(const QJsonObject& json);

    // Getters/Setters
    QString id() const;
    QString name() const;
    QString manaCost() const;
    QString rarity() const;
    QString imageUri() const;
    QStringList colors() const;

    // Méthodes utilitaires
    bool isMonochrome() const;
    bool containsColor(const QString& color) const;
    QJsonObject toJson() const;

    static Card fromJson(const QJsonObject& json);
};
```

---

#### **Set** - Extension Magic
```cpp
class Set {
private:
    QString m_code;           // Code unique (ex: "blb", "khm")
    QString m_name;           // Nom complet
    QDate m_releaseDate;      // Date de sortie
    int m_cardCount;          // Nombre de cartes
    QString m_iconUri;        // URL icône
    QDateTime m_createdAt;

public:
    Set();
    Set(const QString& code, const QString& name);

    QString code() const;
    QString name() const;
    int cardCount() const;

    static Set fromJson(const QJsonObject& json);
};
```

---

#### **Booster** - Générateur de boosters
```cpp
class Booster {
private:
    QString m_setCode;
    QVector<Card> m_cards;

    // Pools de cartes par rareté (cache)
    QMap<QString, QVector<Card>> m_cardPools;

public:
    Booster(const QString& setCode);

    // Génération
    QVector<Card> generate();
    QVector<QVector<Card>> generateMultiple(int count);

    // Configuration
    static constexpr int COMMONS = 10;
    static constexpr int UNCOMMONS = 3;
    static constexpr int RARES = 1;
    static constexpr double MYTHIC_RATE = 0.125;

private:
    QVector<Card> fetchCardsByRarity(const QString& rarity);
    Card pickRandom(const QVector<Card>& pool);
};
```

---

#### **Lobby** - Salle d'attente multijoueur
```cpp
class Lobby {
private:
    QString m_id;             // UUID
    QString m_name;           // Nom du lobby
    QString m_code;           // Code à 5 caractères
    QString m_creatorName;    // Nom du créateur
    QString m_setCode;        // Extension pour le draft
    int m_maxPlayers;         // 4-8
    QString m_status;         // waiting/in_progress/completed
    QDateTime m_createdAt;
    QDateTime m_lastActivity;

    QVector<LobbyPlayer> m_players;

public:
    Lobby();
    Lobby(const QString& name, const QString& code, int maxPlayers);

    // Getters
    QString id() const;
    QString code() const;
    QString status() const;
    int maxPlayers() const;
    int currentPlayerCount() const;
    bool isFull() const;

    // Gestion joueurs
    QVector<LobbyPlayer> players() const;
    void addPlayer(const LobbyPlayer& player);

    static Lobby fromJson(const QJsonObject& json);
    QJsonObject toJson() const;
};
```

---

#### **LobbyPlayer** - Joueur dans un lobby
```cpp
class LobbyPlayer {
private:
    QString m_id;             // UUID
    QString m_lobbyId;        // Référence au lobby
    QString m_playerName;     // Nom du joueur
    int m_seatPosition;       // Position (0-7)
    bool m_isCreator;         // Host du lobby
    QDateTime m_joinedAt;

public:
    LobbyPlayer();
    LobbyPlayer(const QString& lobbyId, const QString& name, int seat);

    QString id() const;
    QString playerName() const;
    int seatPosition() const;
    bool isCreator() const;

    static LobbyPlayer fromJson(const QJsonObject& json);
};
```

---

#### **Draft** - Session de draft en cours
```cpp
class Draft {
private:
    QString m_id;             // UUID
    QString m_lobbyId;        // Référence au lobby
    int m_currentRound;       // 1-3
    int m_currentPick;        // 1-14
    QString m_direction;      // left/right
    QString m_status;         // in_progress/completed
    QDateTime m_startedAt;
    QDateTime m_completedAt;

public:
    Draft();
    Draft(const QString& lobbyId);

    QString id() const;
    int currentRound() const;
    int currentPick() const;
    QString direction() const;
    bool isCompleted() const;

    void advanceRound();
    void nextPick();

    static Draft fromJson(const QJsonObject& json);
};
```

---

#### **DraftPack** - Booster en cours de draft
```cpp
class DraftPack {
private:
    QString m_id;
    QString m_draftId;
    int m_playerSeat;
    int m_roundNumber;
    QVector<Card> m_cards;
    int m_currentOwnerSeat;

public:
    DraftPack();
    DraftPack(const QString& draftId, int playerSeat, int round);

    QVector<Card> cards() const;
    void removeCard(const QString& cardId);
    int currentOwnerSeat() const;
    void setCurrentOwner(int seat);

    static DraftPack fromJson(const QJsonObject& json);
};
```

---

#### **PlayerPool** - Pool de cartes d'un joueur
```cpp
class PlayerPool {
private:
    QString m_id;
    QString m_draftId;
    int m_playerSeat;
    QVector<Card> m_cards;
    QDateTime m_updatedAt;

public:
    PlayerPool();
    PlayerPool(const QString& draftId, int playerSeat);

    QVector<Card> cards() const;
    void addCard(const Card& card);
    int cardCount() const;

    static PlayerPool fromJson(const QJsonObject& json);
};
```

---

### 2️⃣ Couche Manager (Business Logic)

#### **SupabaseClient** - Client Supabase singleton
```cpp
class SupabaseClient {
private:
    static SupabaseClient* s_instance;

    QString m_url;
    QString m_anonKey;
    QNetworkAccessManager* m_networkManager;

    SupabaseClient();

public:
    static SupabaseClient* instance();

    // Initialisation
    void initialize(const QString& url, const QString& key);
    bool isInitialized() const;

    // Requêtes HTTP
    QNetworkReply* select(const QString& table, const QString& columns = "*");
    QNetworkReply* insert(const QString& table, const QJsonObject& data);
    QNetworkReply* update(const QString& table, const QJsonObject& data);
    QNetworkReply* remove(const QString& table);

    // Filtres
    SupabaseClient* eq(const QString& column, const QVariant& value);
    SupabaseClient* order(const QString& column, bool ascending = true);
    SupabaseClient* limit(int count);
};
```

---

#### **DatabaseManager** - Gestionnaire de base de données
```cpp
class DatabaseManager : public QObject {
    Q_OBJECT

private:
    SupabaseClient* m_supabase;
    QMap<QString, QVector<Card>> m_cardCache;

public:
    explicit DatabaseManager(QObject* parent = nullptr);

    // Cards
    void fetchCards(const QString& setCode = "");
    void fetchCardsByRarity(const QString& setCode, const QString& rarity);
    Card getCardById(const QString& id);

    // Sets
    void fetchSets();
    QVector<Set> availableSets() const;

signals:
    void cardsLoaded(const QVector<Card>& cards);
    void setsLoaded(const QVector<Set>& sets);
    void errorOccurred(const QString& error);
};
```

---

#### **LobbyManager** - Gestionnaire de lobbies
```cpp
class LobbyManager : public QObject {
    Q_OBJECT

private:
    SupabaseClient* m_supabase;
    QString m_currentLobbyId;
    QString m_currentPlayerId;
    QTimer* m_refreshTimer;

public:
    explicit LobbyManager(QObject* parent = nullptr);

    // Création/Gestion
    void createLobby(const QString& name, const QString& playerName,
                     int maxPlayers, const QString& setCode);
    void joinLobby(const QString& lobbyId, const QString& playerName);
    void leaveLobby();
    void startDraft();

    // Rafraîchissement
    void fetchLobbies();
    void fetchLobbyDetail(const QString& lobbyId);

    // État
    QString currentLobbyId() const;
    bool isInLobby() const;

signals:
    void lobbiesUpdated(const QVector<Lobby>& lobbies);
    void lobbyDetailUpdated(const Lobby& lobby);
    void lobbyJoined(const QString& lobbyId);
    void lobbyLeft();
    void draftStarted(const QString& draftId);
    void errorOccurred(const QString& error);
};
```

---

#### **DraftManager** - Gestionnaire de draft
```cpp
class DraftManager : public QObject {
    Q_OBJECT

private:
    SupabaseClient* m_supabase;
    QString m_draftId;
    int m_playerSeat;
    Draft m_currentDraft;

public:
    explicit DraftManager(const QString& draftId, QObject* parent = nullptr);

    // Initialisation
    void initialize(const QString& lobbyId, int playerCount, const QString& setCode);

    // État
    void fetchDraftState();
    void fetchCurrentPack(int playerSeat);
    void fetchPlayerPool(int playerSeat);

    // Actions
    void makePick(int playerSeat, const QString& cardId);
    void passPacks();

    // Vérifications
    bool allPicksMade() const;
    bool isDraftComplete() const;

signals:
    void draftStateUpdated(const Draft& draft);
    void currentPackUpdated(const DraftPack& pack);
    void playerPoolUpdated(const PlayerPool& pool);
    void pickMade(int playerSeat, const QString& cardId);
    void roundAdvanced(int newRound);
    void draftCompleted();
    void errorOccurred(const QString& error);
};
```

---

#### **ImageCache** - Cache d'images local
```cpp
class ImageCache : public QObject {
    Q_OBJECT

private:
    QString m_cacheDir;
    QMap<QString, QPixmap> m_memoryCache;
    QNetworkAccessManager* m_networkManager;

public:
    explicit ImageCache(QObject* parent = nullptr);

    // Récupération
    QPixmap getImage(const QString& url);
    void prefetchImage(const QString& url);

    // Cache
    void clearCache();
    qint64 cacheSize() const;

signals:
    void imageReady(const QString& url, const QPixmap& pixmap);

private:
    QString cacheFilePath(const QString& url) const;
    void downloadImage(const QString& url);
};
```

---

### 3️⃣ Couche Interface (UI Layer)

#### **MainWindow** - Fenêtre principale
```cpp
class MainWindow : public QMainWindow {
    Q_OBJECT

private:
    Ui::MainWindow* ui;

    // Managers
    DatabaseManager* m_dbManager;
    LobbyManager* m_lobbyManager;
    DraftManager* m_draftManager;
    ImageCache* m_imageCache;

    // Widgets custom
    RoundTableWidget* m_roundTable;

public:
    explicit MainWindow(QWidget* parent = nullptr);
    ~MainWindow();

private slots:
    // Bibliothèque
    void onCardsLoaded(const QVector<Card>& cards);
    void onCardSelected(int row);

    // Booster
    void onGenerateBooster();
    void displayBooster(const QVector<Card>& cards);

    // Lobby
    void onCreateLobby();
    void onRefreshLobbies();
    void onJoinLobby(const QString& lobbyId);
    void onLeaveLobby();
    void onStartGame();

    // Draft
    void onStartDraft();
    void onPickCard(const QString& cardId);
    void onDraftPackUpdated(const DraftPack& pack);

private:
    void setupUI();
    void setupConnections();
    void loadEnvironment();
};
```

---

#### **RoundTableWidget** - Widget table ronde
```cpp
class RoundTableWidget : public QWidget {
    Q_OBJECT

private:
    QVector<LobbyPlayer> m_players;
    int m_maxPlayers;

public:
    explicit RoundTableWidget(QWidget* parent = nullptr);

    void setPlayers(const QVector<LobbyPlayer>& players, int maxPlayers);

protected:
    void paintEvent(QPaintEvent* event) override;

private:
    void drawTable(QPainter& painter);
    void drawSeats(QPainter& painter);
};
```

---

#### **CardWidget** - Widget affichage carte
```cpp
class CardWidget : public QWidget {
    Q_OBJECT

private:
    Card m_card;
    QPixmap m_cardImage;

public:
    explicit CardWidget(const Card& card, QWidget* parent = nullptr);

    void setCard(const Card& card);
    Card card() const;

protected:
    void paintEvent(QPaintEvent* event) override;
    void mousePressEvent(QMouseEvent* event) override;

signals:
    void clicked();
    void pickRequested(const QString& cardId);
};
```

---

## 🔗 Relations entre Classes

```
┌─────────────────────────────────────────────────────────────┐
│                      MainWindow (UI)                         │
│  - Gère tous les onglets                                     │
│  - Coordonne les managers                                    │
└──────────────┬──────────────┬──────────────┬────────────────┘
               │              │              │
               ▼              ▼              ▼
     ┌─────────────┐  ┌─────────────┐  ┌─────────────┐
     │DatabaseMgr  │  │ LobbyMgr    │  │ DraftMgr    │
     │             │  │             │  │             │
     └──────┬──────┘  └──────┬──────┘  └──────┬──────┘
            │                │                │
            │                │                │
            └────────────────┼────────────────┘
                             ▼
                    ┌─────────────────┐
                    │ SupabaseClient  │
                    │   (Singleton)   │
                    └─────────────────┘
                             │
                             ▼
                    ┌─────────────────┐
                    │  Supabase API   │
                    │   (Backend)     │
                    └─────────────────┘

Modèles de données:
Card ←── Booster
Card ←── DraftPack ←── Draft
Card ←── PlayerPool

Lobby ──┬── LobbyPlayer (1-8)
        └── Draft (0-1)
```

---

## 📊 Diagramme de Flux - Création d'un Draft

```
User                MainWindow         LobbyManager      SupabaseClient
 │                      │                    │                  │
 │  Click "Créer"      │                    │                  │
 ├─────────────────────>│                    │                  │
 │                      │  createLobby()     │                  │
 │                      ├───────────────────>│                  │
 │                      │                    │  INSERT lobby    │
 │                      │                    ├─────────────────>│
 │                      │                    │                  │
 │                      │                    │<─────────────────┤
 │                      │  lobbyCreated      │   lobby_id       │
 │                      │<───────────────────┤                  │
 │                      │                    │                  │
 │  Show lobby detail  │                    │                  │
 │<─────────────────────┤                    │                  │
 │                      │                    │                  │
 │  Click "Lancer"     │                    │                  │
 ├─────────────────────>│                    │                  │
 │                      │  startDraft()      │                  │
 │                      ├───────────────────>│                  │
 │                      │                    │  CREATE draft    │
 │                      │                    ├─────────────────>│
 │                      │                    │  CREATE packs    │
 │                      │                    ├─────────────────>│
 │                      │  draftStarted      │                  │
 │                      │<───────────────────┤                  │
 │  Switch to Draft tab│                    │                  │
 │<─────────────────────┤                    │                  │
```

---

## 🗂️ Hiérarchie des Fichiers C++

```
client_cpp/
├── main.cpp
├── CMakeLists.txt
│
├── model/                    # Modèles de données
│   ├── Card.h / .cpp
│   ├── Set.h / .cpp
│   ├── Booster.h / .cpp
│   ├── Lobby.h / .cpp
│   ├── LobbyPlayer.h / .cpp
│   ├── Draft.h / .cpp
│   ├── DraftPack.h / .cpp
│   └── PlayerPool.h / .cpp
│
├── manager/                  # Logique métier
│   ├── SupabaseClient.h / .cpp
│   ├── DatabaseManager.h / .cpp
│   ├── LobbyManager.h / .cpp
│   ├── DraftManager.h / .cpp
│   └── ImageCache.h / .cpp
│
├── ui/                       # Interface Qt
│   ├── MainWindow.h / .cpp / .ui
│   ├── RoundTableWidget.h / .cpp
│   ├── CardWidget.h / .cpp
│   └── DeckBuilder.ui
│
└── utils/                    # Utilitaires
    ├── Config.h / .cpp
    └── Logger.h / .cpp
```

---

## 🔧 Dépendances CMake

```cmake
# Qt6
find_package(Qt6 COMPONENTS Core Widgets Network REQUIRED)

# Supabase C++ (via CPR + nlohmann/json)
find_package(cpr REQUIRED)
find_package(nlohmann_json REQUIRED)

# Optionnel: WebSocket pour temps réel
find_package(Qt6 COMPONENTS WebSockets REQUIRED)
```

---

## 🎯 Points Clés de l'Architecture

1. **Séparation Model-Manager-UI** : Architecture MVC claire
2. **Communication asynchrone** : Tous les appels Supabase via signals/slots Qt
3. **Cache d'images** : Évite les téléchargements répétés
4. **Singleton Supabase** : Une seule instance du client
5. **État partagé** : Les managers émettent des signaux que l'UI écoute
6. **Typage fort** : Classes C++ avec types stricts vs. Python dynamique
7. **Gestion mémoire** : Smart pointers (QObject ownership) pour éviter les fuites

---

## 📝 Notes d'Implémentation

### Différences Python → C++
- **QVector** au lieu de `list`
- **QString** au lieu de `str`
- **QJsonObject** au lieu de `dict`
- **Signals/Slots Qt** au lieu de callbacks Python
- **Types stricts** (pas de duck typing)
- **Gestion mémoire explicite** (ownership Qt)

### Avantages C++/Qt
- Performance supérieure
- Interface native sur toutes plateformes
- Débogage plus facile avec typage strict
- Meilleure gestion des threads
- Compilation ahead-of-time (pas d'interpréteur)
