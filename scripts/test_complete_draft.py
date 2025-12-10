"""
Complete draft workflow test script.
Demonstrates creating a lobby, starting a draft, and simulating a complete draft with picks.
"""

import sys
from pathlib import Path

project_root = Path(__file__).parent.parent
sys.path.insert(0, str(project_root / "client_py"))

from core.lobby_manager import LobbyManager
from core.draft_manager import DraftManager


def simulate_draft(draft_id: str, player_count: int):
    """Simulate a complete draft with all players making picks.

    Args:
        draft_id: Draft UUID
        player_count: Number of players
    """
    draft_manager = DraftManager(draft_id)
    draft_manager.player_count = player_count

    print("\n" + "=" * 60)
    print("🎲 Simulating Draft")
    print("=" * 60)

    for round_num in range(1, 4):
        print(f"\n📦 Round {round_num}")
        print("-" * 60)

        for pick_num in range(1, 15):
            draft_state = draft_manager.get_draft_state()
            if draft_state["status"] == "completed":
                break

            print(f"\n  Pick {pick_num}:")

            all_picked = True
            for seat in range(player_count):
                pack = draft_manager.get_current_pack(seat)
                if pack and len(pack) > 0:
                    card_to_pick = pack[0]
                    success = draft_manager.make_pick(seat, card_to_pick["id"])
                    if success:
                        print(f"    Player {seat}: {card_to_pick['name']} ({card_to_pick['rarity']})")
                    else:
                        all_picked = False
                else:
                    print(f"    Player {seat}: No pack (waiting)")

            if all_picked:
                draft_manager.pass_packs()

        if draft_manager.get_draft_state()["status"] == "completed":
            break

    print("\n" + "=" * 60)
    print("✅ Draft Simulation Complete")
    print("=" * 60)


def main():
    """Run complete draft test."""
    print("=" * 60)
    print("Basilic - Complete Draft Test")
    print("=" * 60)

    manager = LobbyManager()

    print("\n1️⃣  Creating lobby...")
    lobby = manager.create_lobby(
        name="Complete Draft Test",
        creator_name="Alice",
        max_players=4,
        set_code="khm"
    )
    if not lobby:
        print("❌ Failed to create lobby")
        return

    print(f"   Code: {lobby['code']}")

    print("\n2️⃣  Players joining...")
    for name in ["Bob", "Charlie", "Diana"]:
        manager.join_lobby_by_code(lobby['code'], name)

    players = manager.get_lobby_players(lobby['id'])
    print(f"   Total players: {len(players)}")

    print("\n3️⃣  Starting draft...")
    draft_data = manager.start_draft(lobby['id'])
    if not draft_data:
        print("❌ Failed to start draft")
        return

    draft_id = draft_data["draft_id"]
    print(f"   Draft ID: {draft_id}")

    simulate_draft(draft_id, len(players))

    print("\n4️⃣  Draft Summary...")
    draft_manager = DraftManager(draft_id)
    summary = draft_manager.get_draft_summary()

    print(f"   Status: {summary['draft']['status']}")
    print(f"   Total picks: {summary['total_picks']}")
    print(f"\n   Player Pools:")
    for pool in summary['player_pools']:
        cards = pool['cards']
        if isinstance(cards, str):
            import json
            cards = json.loads(cards)
        print(f"     Player {pool['player_seat']}: {len(cards)} cards")

    print("\n" + "=" * 60)
    print("🎉 Test completed successfully!")
    print("=" * 60)


if __name__ == "__main__":
    main()
