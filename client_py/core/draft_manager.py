"""
Draft management system for Basilic.
Handles the complete draft flow: initialization, picks, pack passing, and state management.
"""

import json
from typing import Optional, List, Dict, Any
from .supabase_client import get_supabase_client
from .booster_generator import generate_draft_boosters


class DraftManager:
    """Manages the draft process including picks and pack passing."""

    def __init__(self, draft_id: str):
        """Initialize draft manager for a specific draft.

        Args:
            draft_id: UUID of the draft
        """
        self.draft_id = draft_id
        self.supabase = get_supabase_client()
        self.draft_data = None
        self.player_count = 0

    def initialize_draft(self, lobby_id: str, player_count: int, set_code: str) -> Optional[str]:
        """Initialize a new draft with boosters for all players.

        Args:
            lobby_id: UUID of the lobby
            player_count: Number of players
            set_code: Set code to draft

        Returns:
            Draft ID if successful, None otherwise
        """
        draft_result = self.supabase.table("drafts").insert({
            "lobby_id": lobby_id,
            "current_round": 1,
            "current_pick": 1,
            "direction": "left",
            "status": "in_progress"
        }).execute()

        if not draft_result.data:
            print("L Failed to create draft")
            return None

        draft_id = draft_result.data[0]["id"]
        self.draft_id = draft_id
        self.player_count = player_count

        boosters = generate_draft_boosters(set_code, player_count, packs_per_player=3)

        for player_seat in range(player_count):
            for round_num in range(1, 4):
                booster_cards = boosters[player_seat][round_num - 1]

                self.supabase.table("draft_packs").insert({
                    "draft_id": draft_id,
                    "player_seat": player_seat,
                    "round_number": round_num,
                    "cards": json.dumps(booster_cards),
                    "current_owner_seat": player_seat
                }).execute()

            self.supabase.table("player_pools").insert({
                "draft_id": draft_id,
                "player_seat": player_seat,
                "cards": json.dumps([])
            }).execute()

        print(f" Draft {draft_id} initialized with {player_count} players")
        return draft_id

    def get_draft_state(self) -> Optional[Dict[str, Any]]:
        """Get current draft state.

        Returns:
            Draft state dictionary
        """
        draft = self.supabase.table("drafts").select("*").eq("id", self.draft_id).maybe_single().execute()

        if not draft.data:
            return None

        return draft.data

    def get_current_pack(self, player_seat: int) -> Optional[List[Dict]]:
        """Get the current pack for a player.

        Args:
            player_seat: Player's seat position

        Returns:
            List of cards in current pack
        """
        draft_state = self.get_draft_state()
        if not draft_state:
            return None

        current_round = draft_state["current_round"]

        pack = self.supabase.table("draft_packs")\
            .select("*")\
            .eq("draft_id", self.draft_id)\
            .eq("round_number", current_round)\
            .eq("current_owner_seat", player_seat)\
            .maybe_single()\
            .execute()

        if not pack.data:
            return None

        cards = json.loads(pack.data["cards"]) if isinstance(pack.data["cards"], str) else pack.data["cards"]
        return cards

    def get_player_pool(self, player_seat: int) -> List[Dict]:
        """Get a player's card pool.

        Args:
            player_seat: Player's seat position

        Returns:
            List of picked cards
        """
        pool = self.supabase.table("player_pools")\
            .select("*")\
            .eq("draft_id", self.draft_id)\
            .eq("player_seat", player_seat)\
            .maybe_single()\
            .execute()

        if not pool.data:
            return []

        cards = json.loads(pool.data["cards"]) if isinstance(pool.data["cards"], str) else pool.data["cards"]
        return cards

    def make_pick(self, player_seat: int, card_id: str) -> bool:
        """Player picks a card from their current pack.

        Args:
            player_seat: Player making the pick
            card_id: ID of card to pick

        Returns:
            True if successful
        """
        draft_state = self.get_draft_state()
        if not draft_state or draft_state["status"] != "in_progress":
            print("L Draft not active")
            return False

        current_round = draft_state["current_round"]
        current_pick = draft_state["current_pick"]

        pack_result = self.supabase.table("draft_packs")\
            .select("*")\
            .eq("draft_id", self.draft_id)\
            .eq("round_number", current_round)\
            .eq("current_owner_seat", player_seat)\
            .maybe_single()\
            .execute()

        if not pack_result.data:
            print("L No pack found for player")
            return False

        pack = pack_result.data
        cards = json.loads(pack["cards"]) if isinstance(pack["cards"], str) else pack["cards"]

        picked_card = None
        remaining_cards = []
        for card in cards:
            if card.get("id") == card_id:
                picked_card = card
            else:
                remaining_cards.append(card)

        if not picked_card:
            print("L Card not found in pack")
            return False

        self.supabase.table("draft_picks").insert({
            "draft_id": self.draft_id,
            "player_seat": player_seat,
            "card_id": card_id,
            "round_number": current_round,
            "pick_number": current_pick
        }).execute()

        pool = self.get_player_pool(player_seat)
        pool.append(picked_card)

        self.supabase.table("player_pools")\
            .update({"cards": json.dumps(pool)})\
            .eq("draft_id", self.draft_id)\
            .eq("player_seat", player_seat)\
            .execute()

        if len(remaining_cards) > 0:
            self.supabase.table("draft_packs")\
                .update({"cards": json.dumps(remaining_cards)})\
                .eq("id", pack["id"])\
                .execute()
        else:
            self.supabase.table("draft_packs")\
                .delete()\
                .eq("id", pack["id"])\
                .execute()

        print(f" Player {player_seat} picked {picked_card.get('name', 'Unknown')}")
        return True

    def pass_packs(self) -> bool:
        """Pass all packs to the next player according to direction.

        Returns:
            True if successful
        """
        draft_state = self.get_draft_state()
        if not draft_state:
            return False

        current_round = draft_state["current_round"]
        direction = draft_state["direction"]
        current_pick = draft_state["current_pick"]

        packs = self.supabase.table("draft_packs")\
            .select("*")\
            .eq("draft_id", self.draft_id)\
            .eq("round_number", current_round)\
            .execute()

        if not packs.data:
            return self._advance_round()

        for pack in packs.data:
            current_owner = pack["current_owner_seat"]

            if direction == "left":
                next_owner = (current_owner + 1) % self.player_count
            else:
                next_owner = (current_owner - 1) % self.player_count

            self.supabase.table("draft_packs")\
                .update({"current_owner_seat": next_owner})\
                .eq("id", pack["id"])\
                .execute()

        self.supabase.table("drafts")\
            .update({"current_pick": current_pick + 1})\
            .eq("id", self.draft_id)\
            .execute()

        print(f" Packs passed {direction}")
        return True

    def _advance_round(self) -> bool:
        """Advance to the next round.

        Returns:
            True if advanced, False if draft complete
        """
        draft_state = self.get_draft_state()
        if not draft_state:
            return False

        current_round = draft_state["current_round"]

        if current_round >= 3:
            self.supabase.table("drafts")\
                .update({
                    "status": "completed",
                    "completed_at": "now()"
                })\
                .eq("id", self.draft_id)\
                .execute()
            print("<� Draft completed!")
            return False

        new_direction = "right" if current_round == 1 else "left"

        self.supabase.table("drafts")\
            .update({
                "current_round": current_round + 1,
                "current_pick": 1,
                "direction": new_direction
            })\
            .eq("id", self.draft_id)\
            .execute()

        print(f" Advanced to round {current_round + 1}, direction: {new_direction}")
        return True

    def check_all_picks_made(self) -> bool:
        """Check if all players have made their picks for current state.

        Returns:
            True if all picks made
        """
        draft_state = self.get_draft_state()
        if not draft_state:
            return False

        current_round = draft_state["current_round"]
        current_pick = draft_state["current_pick"]

        picks = self.supabase.table("draft_picks")\
            .select("player_seat")\
            .eq("draft_id", self.draft_id)\
            .eq("round_number", current_round)\
            .eq("pick_number", current_pick)\
            .execute()

        picks_made = len(picks.data) if picks.data else 0
        return picks_made == self.player_count

    def get_draft_summary(self) -> Dict[str, Any]:
        """Get complete draft summary.

        Returns:
            Summary with all picks and pools
        """
        draft_state = self.get_draft_state()

        picks = self.supabase.table("draft_picks")\
            .select("*")\
            .eq("draft_id", self.draft_id)\
            .order("picked_at")\
            .execute()

        pools = self.supabase.table("player_pools")\
            .select("*")\
            .eq("draft_id", self.draft_id)\
            .order("player_seat")\
            .execute()

        return {
            "draft": draft_state,
            "total_picks": len(picks.data) if picks.data else 0,
            "player_pools": pools.data if pools.data else []
        }
