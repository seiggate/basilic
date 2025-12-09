"""
Example script demonstrating how to use the lobby and draft system.
Shows the complete flow from creating a lobby to starting a draft.
"""

import sys
from pathlib import Path

project_root = Path(__file__).parent.parent
sys.path.insert(0, str(project_root / "client_py"))

from core.lobby_manager import LobbyManager


def main():
    """Demonstrate the complete draft workflow."""
    print("=" * 60)
    print("Basilic Draft - Example Workflow")
    print("=" * 60)
    print()

    manager = LobbyManager()

    print("1️⃣  Fetching available sets...")
    sets = manager.get_available_sets()
    if sets:
        print(f"   Available sets: {', '.join([s['code'].upper() for s in sets])}")
    else:
        print("   ⚠️  No sets found. Run import_to_supabase.py first!")
        return
    print()

    print("2️⃣  Creating a lobby...")
    lobby = manager.create_lobby(
        name="Test Draft",
        creator_name="Alice",
        max_players=6,
        set_code="khm"
    )
    if not lobby:
        print("   ❌ Failed to create lobby")
        return
    print(f"   Lobby code: {lobby['code']}")
    print()

    print("3️⃣  Other players joining...")
    for name in ["Bob", "Charlie", "Diana"]:
        manager.join_lobby_by_code(lobby['code'], name)
    print()

    print("4️⃣  Changing the set...")
    manager.update_lobby_set(lobby['id'], "woe")
    print()

    print("5️⃣  Checking lobby status...")
    players = manager.get_lobby_players(lobby['id'])
    print(f"   Players: {len(players)}/{lobby['max_players']}")
    for player in players:
        creator_tag = " (creator)" if player['is_creator'] else ""
        print(f"   - Seat {player['seat_position']}: {player['player_name']}{creator_tag}")
    print()

    print("6️⃣  Starting the draft...")
    draft = manager.start_draft(lobby['id'])
    if draft:
        print(f"   🎉 Draft started!")
        print(f"   Set: {draft['lobby']['set_code'].upper()}")
        print(f"   Players: {len(draft['players'])}")
        print(f"   Draft ID: {draft['draft_id']}")
        print()
        print("   💡 Use test_complete_draft.py to simulate a full draft")
    else:
        print("   ❌ Failed to start draft")

    print()
    print("=" * 60)


if __name__ == "__main__":
    main()
