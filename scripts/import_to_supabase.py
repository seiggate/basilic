"""
Import cards from Scryfall API to Supabase database.
This script fetches card data and stores it in the Supabase cards and sets tables.
"""

import requests
import time
import os
import sys
from pathlib import Path

project_root = Path(__file__).parent.parent
sys.path.insert(0, str(project_root / "client_py"))

from core.supabase_client import get_supabase_client

SCRYFALL_SETS_API = "https://api.scryfall.com/sets"
SCRYFALL_CARDS_API = "https://api.scryfall.com/cards/search"

DEFAULT_SETS = ["khm", "woe", "otj", "lci", "mkm", "blb", "dsk"]


def import_sets():
    """Import set information from Scryfall."""
    print("📦 Importing sets from Scryfall...")

    supabase = get_supabase_client()
    response = requests.get(SCRYFALL_SETS_API)

    if response.status_code != 200:
        print(f"❌ Error fetching sets: HTTP {response.status_code}")
        return

    data = response.json()
    sets_data = []

    for set_info in data["data"]:
        if set_info["code"] in DEFAULT_SETS:
            sets_data.append({
                "code": set_info["code"],
                "name": set_info["name"],
                "release_date": set_info.get("released_at"),
                "card_count": set_info.get("card_count", 0),
                "icon_uri": set_info.get("icon_svg_uri")
            })

    if sets_data:
        result = supabase.table("sets").upsert(sets_data).execute()
        print(f"✅ Imported {len(sets_data)} sets")


def import_cards_for_set(set_code):
    """Import all cards for a specific set."""
    print(f"📦 Importing cards for set: {set_code}")

    supabase = get_supabase_client()
    query = f"set:{set_code}"
    url = f"{SCRYFALL_CARDS_API}?q={query}"
    count = 0

    while url:
        response = requests.get(url)
        if response.status_code != 200:
            print(f"❌ Error HTTP {response.status_code}")
            break

        data = response.json()
        cards_batch = []

        for card in data["data"]:
            if card.get("layout") in ["token", "double_faced_token", "art_series"]:
                continue

            # Handle double-faced cards
            image_uri = ""
            image_uri_small = ""
            if "image_uris" in card:
                image_uri = card["image_uris"].get("normal", "")
                image_uri_small = card["image_uris"].get("small", "")
            elif "card_faces" in card and len(card["card_faces"]) > 0:
                if "image_uris" in card["card_faces"][0]:
                    image_uri = card["card_faces"][0]["image_uris"].get("normal", "")
                    image_uri_small = card["card_faces"][0]["image_uris"].get("small", "")

            card_data = {
                "id": card["id"],
                "name": card["name"],
                "mana_cost": card.get("mana_cost", ""),
                "cmc": card.get("cmc", 0),
                "type_line": card.get("type_line", ""),
                "oracle_text": card.get("oracle_text", ""),
                "colors": card.get("colors", []),
                "rarity": card.get("rarity", "common"),
                "set_code": card.get("set", ""),
                "collector_number": card.get("collector_number", ""),
                "image_uri": image_uri,
                "image_uri_small": image_uri_small,
                "prices": card.get("prices", {})
            }

            cards_batch.append(card_data)
            count += 1

        if cards_batch:
            supabase.table("cards").upsert(cards_batch).execute()
            print(f"✅ {count} cards imported for {set_code}...")

        url = data.get("next_page", None)
        if url:
            time.sleep(0.1)

    print(f"🎉 Import completed for {set_code}: {count} cards")


def main():
    """Main import function."""
    print("🚀 Starting Scryfall to Supabase import")

    import_sets()

    for set_code in DEFAULT_SETS:
        import_cards_for_set(set_code)
        time.sleep(0.5)

    print("🎉 All imports completed!")


if __name__ == "__main__":
    main()
