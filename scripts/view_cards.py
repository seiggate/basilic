import sqlite3
import os

# --- Emplacement de la base ---
DB_PATH = os.path.join(os.path.dirname(__file__), "..", "database", "basilic.db")

def query_db():
    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()

    print("=== Recherche de cartes dans la base ===")
    print("Exemples de filtres :")
    print(" - set:khm")
    print(" - rarity:rare")
    print(" - name:dragon")
    print(" - type:creature")
    print("Laisse vide pour afficher 10 cartes au hasard.\n")

    user_input = input("Filtre : ").strip().lower()

    # Construction dynamique de la requête
    sql = "SELECT name, type_line, rarity, set_code FROM cards"
    params = ()

    if user_input:
        if user_input.startswith("set:"):
            sql += " WHERE set_code = ?"
            params = (user_input.split(":")[1],)
        elif user_input.startswith("rarity:"):
            sql += " WHERE rarity = ?"
            params = (user_input.split(":")[1],)
        elif user_input.startswith("name:"):
            sql += " WHERE LOWER(name) LIKE ?"
            params = (f"%{user_input.split(':')[1]}%",)
        elif user_input.startswith("type:"):
            sql += " WHERE LOWER(type_line) LIKE ?"
            params = (f"%{user_input.split(':')[1]}%",)
        else:
            print("⚠️  Filtre non reconnu, affichage aléatoire.")
    else:
        sql += " ORDER BY RANDOM()"

    sql += " LIMIT 10"
    cursor.execute(sql, params)
    results = cursor.fetchall()

    if not results:
        print("❌ Aucune carte trouvée.")
    else:
        print("\n--- Résultats ---")
        for name, type_line, rarity, set_code in results:
            print(f"{name:40} | {type_line:30} | {rarity:8} | {set_code}")

    conn.close()


if __name__ == "__main__":
    query_db()
