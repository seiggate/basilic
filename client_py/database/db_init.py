# client_py/database/db_init.py
import sqlite3
from pathlib import Path

DB_PATH = Path(__file__).parent / "basilic.db"

def create_database():
    conn = sqlite3.connect(DB_PATH)
    c = conn.cursor()

    # --- Tables principales ---
    c.execute("""
    CREATE TABLE IF NOT EXISTS sets (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        code TEXT NOT NULL,
        release_date TEXT
    )
    """)

    c.execute("""
    CREATE TABLE IF NOT EXISTS cards (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        set_code TEXT NOT NULL,
        mana_cost TEXT,
        type_line TEXT,
        rarity TEXT,
        oracle_text TEXT,
        power TEXT,
        toughness TEXT,
        image_url TEXT,
        FOREIGN KEY (set_code) REFERENCES sets(code)
    )
    """)

    c.execute("""
    CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT UNIQUE NOT NULL,
        password_hash TEXT NOT NULL,
        created_at TEXT DEFAULT CURRENT_TIMESTAMP
    )
    """)

    c.execute("""
    CREATE TABLE IF NOT EXISTS cubes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        description TEXT,
        owner_id INTEGER,
        FOREIGN KEY (owner_id) REFERENCES users(id)
    )
    """)

    c.execute("""
    CREATE TABLE IF NOT EXISTS cube_cards (
        cube_id INTEGER,
        card_id TEXT,
        FOREIGN KEY (cube_id) REFERENCES cubes(id),
        FOREIGN KEY (card_id) REFERENCES cards(id)
    )
    """)

    conn.commit()
    conn.close()
    print(f"✅ Base de données créée à : {DB_PATH}")

if __name__ == "__main__":
    create_database()
