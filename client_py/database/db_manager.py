# client_py/database/db_manager.py
import sqlite3

class DatabaseManager:
    def __init__(self, db_path="../database/basilic.db"):
        self.db_path = db_path

    def connect(self):
        return sqlite3.connect(self.db_path)

    def get_cards(self, limit=50):
        """Récupère cartes avec image"""
        conn = self.connect()
        cursor = conn.cursor()
        cursor.execute("""
            SELECT name, mana_cost, type_line, rarity, image_url
            FROM cards
            LIMIT ?
        """, (limit,))
        rows = cursor.fetchall()
        conn.close()
        return rows
