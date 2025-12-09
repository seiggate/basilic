"""
Lobby management system for Basilic draft.
Handles lobby creation, joining, set selection, and draft initialization.
"""

import random
import string
from typing import Optional, List, Dict
from .supabase_client import get_supabase_client
from .booster_generator import generate_draft_boosters


class LobbyManager:
    """Manages draft lobbies with set selection support."""

    def __init__(self):
        """Initialize the lobby manager."""
        self.supabase = get_supabase_client()

    def _generate_code(self, length: int = 5) -> str:
        """Generate a random lobby code.

        Args:
            length: Length of the code (default 5)

        Returns:
            Random uppercase alphanumeric code
        """
        return ''.join(random.choices(string.ascii_uppercase + string.digits, k=length))

    def create_lobby(self, name: str, creator_name: str, max_players: int = 8, set_code: str = "khm") -> Optional[Dict]:
        """Create a new draft lobby.

        Args:
            name: Lobby name
            creator_name: Name of the creator
            max_players: Maximum number of players (4-8)
            set_code: Set code for the draft (default 'khm')

        Returns:
            Lobby data dictionary or None on error
        """
        code = self._generate_code()

        while True:
            existing = self.supabase.table("lobbies").select("id").eq("code", code).execute()
            if not existing.data:
                break
            code = self._generate_code()

        lobby_data = {
            "name": name,
            "code": code,
            "creator_name": creator_name,
            "max_players": max_players,
            "set_code": set_code,
            "status": "waiting"
        }

        result = self.supabase.table("lobbies").insert(lobby_data).execute()

        if result.data:
            lobby = result.data[0]
            self.join_lobby(lobby["id"], creator_name, is_creator=True)
            print(f"✅ Lobby created: {name} (Code: {code})")
            return lobby

        return None

    def join_lobby(self, lobby_id: str, player_name: str, is_creator: bool = False) -> Optional[Dict]:
        """Join an existing lobby.

        Args:
            lobby_id: Lobby UUID
            player_name: Player name
            is_creator: Whether this player is the creator

        Returns:
            Player data dictionary or None on error
        """
        lobby = self.supabase.table("lobbies").select("*").eq("id", lobby_id).maybe_single().execute()

        if not lobby.data or lobby.data["status"] != "waiting":
            print("❌ Lobby not available")
            return None

        players = self.supabase.table("lobby_players").select("*").eq("lobby_id", lobby_id).execute()
        current_count = len(players.data) if players.data else 0

        if current_count >= lobby.data["max_players"]:
            print("❌ Lobby is full")
            return None

        player_data = {
            "lobby_id": lobby_id,
            "player_name": player_name,
            "seat_position": current_count,
            "is_creator": is_creator
        }

        result = self.supabase.table("lobby_players").insert(player_data).execute()

        if result.data:
            print(f"✅ {player_name} joined lobby")
            return result.data[0]

        return None

    def join_lobby_by_code(self, code: str, player_name: str) -> Optional[Dict]:
        """Join a lobby using its code.

        Args:
            code: 5-character lobby code
            player_name: Player name

        Returns:
            Player data dictionary or None on error
        """
        lobby = self.supabase.table("lobbies").select("*").eq("code", code).maybe_single().execute()

        if not lobby.data:
            print(f"❌ Lobby with code {code} not found")
            return None

        return self.join_lobby(lobby.data["id"], player_name)

    def update_lobby_set(self, lobby_id: str, set_code: str) -> bool:
        """Update the set for a lobby (only allowed before start).

        Args:
            lobby_id: Lobby UUID
            set_code: New set code

        Returns:
            True if successful, False otherwise
        """
        lobby = self.supabase.table("lobbies").select("status").eq("id", lobby_id).maybe_single().execute()

        if not lobby.data or lobby.data["status"] != "waiting":
            print("❌ Cannot change set: lobby already started")
            return False

        result = self.supabase.table("lobbies").update({"set_code": set_code}).eq("id", lobby_id).execute()

        if result.data:
            print(f"✅ Lobby set changed to {set_code.upper()}")
            return True

        return False

    def get_lobby_players(self, lobby_id: str) -> List[Dict]:
        """Get all players in a lobby.

        Args:
            lobby_id: Lobby UUID

        Returns:
            List of player dictionaries
        """
        result = self.supabase.table("lobby_players")\
            .select("*")\
            .eq("lobby_id", lobby_id)\
            .order("seat_position")\
            .execute()

        return result.data if result.data else []

    def get_available_lobbies(self) -> List[Dict]:
        """Get all available lobbies.

        Returns:
            List of lobby dictionaries
        """
        result = self.supabase.table("lobbies")\
            .select("*")\
            .eq("status", "waiting")\
            .order("created_at", desc=True)\
            .execute()

        return result.data if result.data else []

    def get_available_sets(self) -> List[Dict]:
        """Get all available sets for drafting.

        Returns:
            List of set dictionaries
        """
        result = self.supabase.table("sets")\
            .select("*")\
            .order("release_date", desc=True)\
            .execute()

        return result.data if result.data else []

    def start_draft(self, lobby_id: str) -> Optional[Dict]:
        """Start the draft for a lobby.

        Args:
            lobby_id: Lobby UUID

        Returns:
            Draft data with boosters or None on error
        """
        lobby = self.supabase.table("lobbies").select("*").eq("id", lobby_id).maybe_single().execute()

        if not lobby.data:
            print("❌ Lobby not found")
            return None

        if lobby.data["status"] != "waiting":
            print("❌ Lobby already started")
            return None

        players = self.get_lobby_players(lobby_id)
        player_count = len(players)

        if player_count < 4:
            print("❌ Need at least 4 players to start")
            return None

        self.supabase.table("lobbies").update({"status": "in_progress"}).eq("id", lobby_id).execute()

        set_code = lobby.data["set_code"]
        draft_boosters = generate_draft_boosters(set_code, player_count)

        print(f"🎉 Draft started with {player_count} players!")
        return {
            "lobby": lobby.data,
            "players": players,
            "boosters": draft_boosters
        }

    def leave_lobby(self, lobby_id: str, player_name: str) -> bool:
        """Leave a lobby.

        Args:
            lobby_id: Lobby UUID
            player_name: Player name

        Returns:
            True if successful, False otherwise
        """
        result = self.supabase.table("lobby_players")\
            .delete()\
            .eq("lobby_id", lobby_id)\
            .eq("player_name", player_name)\
            .execute()

        if result.data:
            print(f"✅ {player_name} left the lobby")
            return True

        return False
