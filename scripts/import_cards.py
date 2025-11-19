import requests
import sqlite3
import os
import time

# === CONFIGURATION ===
DB_PATH = os.path.join(os.path.dirname(__file__), "..", "database", "basilic.db")
SCRYFALL_API = "https://api.scryfall.com/cards/search"
QUERY = "set:khm or set:woe or set:otj"  # tout les sets

# === CRÉATION DE LA BASE SI ELLE N'EXISTE PAS ===
os.makedirs(os.path.dirname(DB_PATH), exist_ok=True)

conn = sqlite3.connect(DB_PATH)
cursor = conn.cursor()

cursor.execute("""
CREATE TABLE IF NOT EXISTS cards (
    id TEXT PRIMARY KEY,
    name TEXT,
    mana_cost TEXT,
    type_line TEXT,
    rarity TEXT,
    set_code TEXT,
    collector_number TEXT,
    image_url TEXT,
    oracle_text TEXT
)
""")
conn.commit()

# === FONCTION POUR IMPORTER LES CARTES ===
def import_cards(query):
    print(f"📦 Import des cartes depuis Scryfall avec la requête : {query}")
    url = f"{SCRYFALL_API}?q={query}"
    count = 0

    while url:
        response = requests.get(url)
        if response.status_code != 200:
            print(f"❌ Erreur HTTP {response.status_code}")
            break

        data = response.json()
        for card in data["data"]:
            if card.get("layout") in ["token", "double_faced_token"]:
                continue  # on ignore les tokens

            card_id = card["id"]
            name = card["name"]
            mana_cost = card.get("mana_cost", "")
            type_line = card.get("type_line", "")
            rarity = card.get("rarity", "")
            set_code = card.get("set", "")
            collector_number = card.get("collector_number", "")
            oracle_text = card.get("oracle_text", "")
            image_url = card.get("image_uris", {}).get("normal", "")

            cursor.execute("""
                INSERT OR REPLACE INTO cards 
                (id, name, mana_cost, type_line, rarity, set_code, collector_number, image_url, oracle_text)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
            """, (card_id, name, mana_cost, type_line, rarity, set_code, collector_number, image_url, oracle_text))

            count += 1

        conn.commit()
        print(f"✅ {count} cartes importées jusque-là...")

        # Pagination : on passe à la page suivante si elle existe
        url = data.get("next_page", None)
        if url:
            time.sleep(0.1)  # petit délai pour éviter d’être bloqué par l’API

    print(f"🎉 Import terminé : {count} cartes ajoutées dans la base.")

# === LANCEMENT ===
if __name__ == "__main__":
    import_cards(QUERY)
    conn.close()
