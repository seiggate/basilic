#include "model/Card.h"
#include "model/Set.h"
#include "model/Booster.h"
#include "model/Lobby.h"
#include "model/LobbyPlayer.h"
#include "model/Draft.h"
#include "model/DraftPack.h"
#include "model/PlayerPool.h"
#include <QCoreApplication>
#include <QDebug>
#include <QJsonDocument>

void testCard()
{
    qDebug() << "\n=== Test Card ===";

    Card card;
    card.setId("test-card-123");
    card.setName("Lightning Bolt");
    card.setManaCost("{R}");
    card.setCmc(1.0);
    card.setTypeLine("Instant");
    card.setOracleText("Deal 3 damage to any target.");
    card.setColors(QStringList{"R"});
    card.setRarity("common");
    card.setSetCode("LEA");

    qDebug() << "Card Name:" << card.name();
    qDebug() << "Mana Cost:" << card.manaCost();
    qDebug() << "CMC:" << card.cmc();
    qDebug() << "Is Valid:" << card.isValid();
    qDebug() << "Is Monochrome:" << card.isMonochrome();
    qDebug() << "Contains Red:" << card.containsColor("R");

    QJsonObject json = card.toJson();
    qDebug() << "JSON:" << QJsonDocument(json).toJson(QJsonDocument::Compact);

    Card card2 = Card::fromJson(json);
    qDebug() << "Deserialized Name:" << card2.name();
}

void testSet()
{
    qDebug() << "\n=== Test Set ===";

    Set set("DOM", "Dominaria");
    set.setReleaseDate(QDate(2018, 4, 27));
    set.setCardCount(269);

    qDebug() << "Set Code:" << set.code();
    qDebug() << "Set Name:" << set.name();
    qDebug() << "Card Count:" << set.cardCount();
    qDebug() << "Is Valid:" << set.isValid();

    QJsonObject json = set.toJson();
    qDebug() << "JSON:" << QJsonDocument(json).toJson(QJsonDocument::Compact);
}

void testBooster()
{
    qDebug() << "\n=== Test Booster ===";

    Booster booster("DOM");
    qDebug() << "Booster Set Code:" << booster.setCode();
    qDebug() << "Constants: Commons=" << Booster::COMMONS
             << ", Uncommons=" << Booster::UNCOMMONS
             << ", Rares=" << Booster::RARES
             << ", Mythic Rate=" << Booster::MYTHIC_RATE;

    QVector<Card> pack = booster.generate();
    qDebug() << "Generated pack size:" << pack.size();
}

void testLobby()
{
    qDebug() << "\n=== Test Lobby ===";

    Lobby lobby("My Draft Lobby", "ABC123", 8);
    lobby.setId("lobby-456");
    lobby.setCreatorName("Alice");
    lobby.setSetCode("DOM");
    lobby.setStatus("waiting");

    LobbyPlayer player1("lobby-456", "Alice", 0);
    player1.setId("player-1");
    player1.setIsCreator(true);

    LobbyPlayer player2("lobby-456", "Bob", 1);
    player2.setId("player-2");

    lobby.addPlayer(player1);
    lobby.addPlayer(player2);

    qDebug() << "Lobby Name:" << lobby.name();
    qDebug() << "Lobby Code:" << lobby.code();
    qDebug() << "Creator:" << lobby.creatorName();
    qDebug() << "Max Players:" << lobby.maxPlayers();
    qDebug() << "Current Players:" << lobby.currentPlayerCount();
    qDebug() << "Is Full:" << lobby.isFull();
    qDebug() << "Is Valid:" << lobby.isValid();

    QJsonObject json = lobby.toJson();
    qDebug() << "JSON:" << QJsonDocument(json).toJson(QJsonDocument::Compact);
}

void testDraft()
{
    qDebug() << "\n=== Test Draft ===";

    Draft draft("lobby-789");
    draft.setId("draft-001");

    qDebug() << "Draft ID:" << draft.id();
    qDebug() << "Lobby ID:" << draft.lobbyId();
    qDebug() << "Current Round:" << draft.currentRound();
    qDebug() << "Current Pick:" << draft.currentPick();
    qDebug() << "Direction:" << draft.direction();
    qDebug() << "Status:" << draft.status();
    qDebug() << "Is In Progress:" << draft.isInProgress();

    draft.nextPick();
    qDebug() << "After nextPick() - Pick:" << draft.currentPick();

    draft.advanceRound();
    qDebug() << "After advanceRound() - Round:" << draft.currentRound()
             << ", Direction:" << draft.direction();

    QJsonObject json = draft.toJson();
    qDebug() << "JSON:" << QJsonDocument(json).toJson(QJsonDocument::Compact);
}

void testDraftPack()
{
    qDebug() << "\n=== Test DraftPack ===";

    DraftPack pack("draft-001", 0, 1);
    pack.setId("pack-1");

    Card card1;
    card1.setId("card-1");
    card1.setName("Forest");

    Card card2;
    card2.setId("card-2");
    card2.setName("Mountain");

    QVector<Card> cards;
    cards.append(card1);
    cards.append(card2);
    pack.setCards(cards);

    qDebug() << "Pack ID:" << pack.id();
    qDebug() << "Draft ID:" << pack.draftId();
    qDebug() << "Player Seat:" << pack.playerSeat();
    qDebug() << "Round:" << pack.roundNumber();
    qDebug() << "Card Count:" << pack.cardCount();
    qDebug() << "Is Empty:" << pack.isEmpty();

    pack.removeCard("card-1");
    qDebug() << "After removing card - Count:" << pack.cardCount();
}

void testPlayerPool()
{
    qDebug() << "\n=== Test PlayerPool ===";

    PlayerPool pool("draft-001", 0);
    pool.setId("pool-1");

    Card card;
    card.setId("picked-card-1");
    card.setName("Serra Angel");

    pool.addCard(card);

    qDebug() << "Pool ID:" << pool.id();
    qDebug() << "Draft ID:" << pool.draftId();
    qDebug() << "Player Seat:" << pool.playerSeat();
    qDebug() << "Card Count:" << pool.cardCount();
    qDebug() << "Is Valid:" << pool.isValid();

    QJsonObject json = pool.toJson();
    qDebug() << "JSON:" << QJsonDocument(json).toJson(QJsonDocument::Compact);
}

int main(int argc, char *argv[])
{
    QCoreApplication app(argc, argv);

    qDebug() << "===================================";
    qDebug() << "Testing Basilic C++ Models";
    qDebug() << "===================================";

    testCard();
    testSet();
    testBooster();
    testLobby();
    testDraft();
    testDraftPack();
    testPlayerPool();

    qDebug() << "\n===================================";
    qDebug() << "All tests completed!";
    qDebug() << "===================================";

    return 0;
}
