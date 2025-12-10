"""
Quick script to check the status of the Supabase database.
Shows what sets and cards are available.
"""

import sys
from pathlib import Path

project_root = Path(__file__).parent.parent
sys.path.insert(0, str(project_root / "client_py"))

from core.supabase_client import get_supabase_client


def check_database():
    """Check database status and display summary."""
    print("=" * 60)
    print("Basilic - Database Status")
    print("=" * 60)
    print()

    supabase = get_supabase_client()

    print("📊 Checking sets...")
    sets_result = supabase.table("sets").select("code, name, card_count").execute()

    if sets_result.data:
        print(f"   ✅ Found {len(sets_result.data)} sets:")
        for s in sets_result.data:
            print(f"      - {s['code'].upper()}: {s['name']} ({s['card_count']} cards)")
    else:
        print("   ⚠️  No sets found. Run 'python scripts/import_to_supabase.py'")
    print()

    print("🃏 Checking cards...")
    cards_result = supabase.table("cards").select("set_code, rarity", count="exact").execute()

    if cards_result.data:
        total_cards = cards_result.count
        print(f"   ✅ Total cards: {total_cards}")

        by_set = {}
        by_rarity = {"common": 0, "uncommon": 0, "rare": 0, "mythic": 0}

        for card in cards_result.data:
            set_code = card['set_code']
            rarity = card['rarity']

            by_set[set_code] = by_set.get(set_code, 0) + 1
            by_rarity[rarity] = by_rarity.get(rarity, 0) + 1

        print("   By set:")
        for set_code, count in sorted(by_set.items()):
            print(f"      - {set_code.upper()}: {count} cards")

        print("   By rarity:")
        for rarity, count in by_rarity.items():
            print(f"      - {rarity.capitalize()}: {count} cards")
    else:
        print("   ⚠️  No cards found. Run 'python scripts/import_to_supabase.py'")
    print()

    print("🏠 Checking lobbies...")
    lobbies_result = supabase.table("lobbies").select("*", count="exact").execute()
    print(f"   Lobbies: {lobbies_result.count}")

    if lobbies_result.data:
        waiting = sum(1 for l in lobbies_result.data if l['status'] == 'waiting')
        in_progress = sum(1 for l in lobbies_result.data if l['status'] == 'in_progress')
        completed = sum(1 for l in lobbies_result.data if l['status'] == 'completed')

        print(f"      - Waiting: {waiting}")
        print(f"      - In progress: {in_progress}")
        print(f"      - Completed: {completed}")
    print()

    print("=" * 60)

    if sets_result.data and cards_result.data:
        print("✅ Database ready!")
        print("   You can now create lobbies and start drafts.")
    else:
        print("⚠️  Database needs setup!")
        print("   Run: python scripts/import_to_supabase.py")

    print("=" * 60)


if __name__ == "__main__":
    check_database()
