"""
Interactive draft simulator - Command line version.
Allows you to participate in a draft as one player while AI controls others.
"""

import sys
from pathlib import Path

project_root = Path(__file__).parent.parent
sys.path.insert(0, str(project_root / "client_py"))

from core.lobby_manager import LobbyManager
from core.draft_manager import DraftManager
import random


def display_pack(cards, title="Current Pack"):
    """Display cards in a pack."""
    print(f"\n{title}")
    print("-" * 80)
    for i, card in enumerate(cards, 1):
        rarity_colors = {
            "common": "",
            "uncommon": "🔹",
            "rare": "⭐",
            "mythic": "💎"
        }
        icon = rarity_colors.get(card.get("rarity", "common"), "")
        print(f"  {i}. {icon} {card['name']} ({card['rarity']}) - {card.get('type_line', 'Unknown')}")
    print("-" * 80)


def display_pool(cards):
    """Display player's card pool."""
    if not cards:
        print("\n📦 Your pool is empty")
        return

    print(f"\n📦 Your Pool ({len(cards)} cards)")
    print("-" * 80)

    by_rarity = {}
    for card in cards:
        rarity = card.get("rarity", "common")
        if rarity not in by_rarity:
            by_rarity[rarity] = []
        by_rarity[rarity].append(card['name'])

    for rarity in ["mythic", "rare", "uncommon", "common"]:
        if rarity in by_rarity:
            print(f"  {rarity.upper()}: {len(by_rarity[rarity])} cards")
    print("-" * 80)


def ai_pick(pack):
    """AI picks a card (simple random for now)."""
    if not pack:
        return None
    return random.choice(pack)["id"]


def interactive_draft(draft_id: str, player_count: int, player_seat: int = 0):
    """Run an interactive draft where user controls one player.

    Args:
        draft_id: Draft UUID
        player_count: Total number of players
        player_seat: Seat position of human player (default 0)
    """
    draft_manager = DraftManager(draft_id)
    draft_manager.player_count = player_count

    print("\n" + "=" * 80)
    print("🎮 Interactive Draft - You are Player {}".format(player_seat))
    print("=" * 80)

    while True:
        draft_state = draft_manager.get_draft_state()
        if not draft_state or draft_state["status"] == "completed":
            break

        round_num = draft_state["current_round"]
        pick_num = draft_state["current_pick"]

        print(f"\n{'=' * 80}")
        print(f"Round {round_num} - Pick {pick_num}")
        print(f"{'=' * 80}")

        pack = draft_manager.get_current_pack(player_seat)

        if not pack or len(pack) == 0:
            print("\n⏳ Waiting for other players...")
            break

        display_pack(pack, f"Your Pack ({len(pack)} cards remaining)")

        pool = draft_manager.get_player_pool(player_seat)
        if pool:
            display_pool(pool)

        while True:
            try:
                choice = input("\nPick a card (1-{}) or 'q' to quit: ".format(len(pack)))
                if choice.lower() == 'q':
                    print("Exiting draft...")
                    return

                pick_index = int(choice) - 1
                if 0 <= pick_index < len(pack):
                    card_id = pack[pick_index]["id"]
                    success = draft_manager.make_pick(player_seat, card_id)
                    if success:
                        print(f"\n✅ You picked: {pack[pick_index]['name']}")
                        break
                    else:
                        print("❌ Failed to make pick, try again")
                else:
                    print(f"Invalid choice. Enter 1-{len(pack)}")
            except ValueError:
                print("Invalid input. Enter a number or 'q'")
            except KeyboardInterrupt:
                print("\nExiting draft...")
                return

        print("\n⏳ Other players making picks...")
        for seat in range(player_count):
            if seat == player_seat:
                continue

            ai_pack = draft_manager.get_current_pack(seat)
            if ai_pack and len(ai_pack) > 0:
                ai_card_id = ai_pick(ai_pack)
                draft_manager.make_pick(seat, ai_card_id)

        if draft_manager.check_all_picks_made():
            draft_manager.pass_packs()
            print("✅ Packs passed!")
        else:
            print("⚠️  Not all picks made yet")

    print("\n" + "=" * 80)
    print("🎉 Draft Complete!")
    print("=" * 80)

    pool = draft_manager.get_player_pool(player_seat)
    display_pool(pool)

    summary = draft_manager.get_draft_summary()
    print(f"\n📊 Total picks in draft: {summary['total_picks']}")


def main():
    """Set up and run interactive draft."""
    print("=" * 80)
    print("Basilic - Interactive Draft")
    print("=" * 80)

    manager = LobbyManager()

    print("\n1️⃣  Creating lobby...")
    lobby = manager.create_lobby(
        name="Interactive Draft",
        creator_name="You",
        max_players=4,
        set_code="khm"
    )
    if not lobby:
        print("❌ Failed to create lobby")
        return

    print(f"   Code: {lobby['code']}")

    print("\n2️⃣  Adding AI players...")
    for i, name in enumerate(["AI-Bob", "AI-Charlie", "AI-Diana"], 1):
        manager.join_lobby_by_code(lobby['code'], name)
        print(f"   {name} joined")

    players = manager.get_lobby_players(lobby['id'])

    print("\n3️⃣  Starting draft...")
    draft_data = manager.start_draft(lobby['id'])
    if not draft_data:
        print("❌ Failed to start draft")
        return

    draft_id = draft_data["draft_id"]

    interactive_draft(draft_id, len(players), player_seat=0)

    print("\n✅ Session complete!")


if __name__ == "__main__":
    main()
