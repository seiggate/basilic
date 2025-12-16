"""
Quick import of Bloomburrow cards using direct API calls.
This bypasses the Supabase client to work around connection issues.
"""

import requests
import time

SCRYFALL_SETS_API = "https://api.scryfall.com/sets"
SCRYFALL_CARDS_API = "https://api.scryfall.com/cards/search"

def fetch_set_info(set_code):
    """Fetch set info from Scryfall."""
    response = requests.get(f"{SCRYFALL_SETS_API}/{set_code}")
    if response.status_code == 200:
        return response.json()
    return None

def fetch_cards_for_set(set_code):
    """Fetch all cards for a set from Scryfall."""
    print(f"Fetching cards for {set_code}...")

    query = f"set:{set_code}"
    url = f"{SCRYFALL_CARDS_API}?q={query}"
    all_cards = []

    while url:
        response = requests.get(url)
        if response.status_code != 200:
            print(f"Error: HTTP {response.status_code}")
            break

        data = response.json()

        for card in data["data"]:
            # Skip tokens
            if card.get("layout") in ["token", "double_faced_token", "art_series"]:
                continue

            # Handle images
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
            }

            all_cards.append(card_data)

        url = data.get("next_page", None)
        if url:
            time.sleep(0.1)

    return all_cards

def main():
    """Fetch and display cards from BLB."""
    print("Fetching Bloomburrow (BLB) cards from Scryfall...")

    # Get set info
    set_info = fetch_set_info("blb")
    if set_info:
        print(f"Set: {set_info['name']}")
        print(f"Released: {set_info.get('released_at')}")
        print(f"Card count: {set_info.get('card_count')}")

    # Get cards
    cards = fetch_cards_for_set("blb")
    print(f"\n✅ Fetched {len(cards)} cards")

    # Save to file for manual import
    import json
    output_file = "/tmp/cc-agent/61333761/project/data/blb_cards.json"
    with open(output_file, 'w', encoding='utf-8') as f:
        json.dump({"set": set_info, "cards": cards}, f, indent=2, ensure_ascii=False)

    print(f"\n💾 Saved to {output_file}")
    print("\nSample cards:")
    for i, card in enumerate(cards[:5]):
        print(f"{i+1}. {card['name']} - {card['rarity']} - {card['type_line']}")

if __name__ == "__main__":
    main()
