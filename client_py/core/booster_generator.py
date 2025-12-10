"""
Booster pack generation logic for Magic: The Gathering draft.
Generates realistic booster packs based on set code with proper rarity distribution.
"""

import random
from typing import List, Dict
from .supabase_client import get_supabase_client


class BoosterGenerator:
    """Generates booster packs for a specific set."""

    RARITY_DISTRIBUTION = {
        "common": 10,
        "uncommon": 3,
        "rare": 1,
        "mythic": 0
    }

    MYTHIC_RATE = 0.125

    def __init__(self, set_code: str):
        """Initialize booster generator for a specific set.

        Args:
            set_code: The set code (e.g., 'khm', 'woe')
        """
        self.set_code = set_code
        self.supabase = get_supabase_client()
        self._card_pools = {}

    def _fetch_cards_by_rarity(self, rarity: str) -> List[Dict]:
        """Fetch all cards of a specific rarity from the set.

        Args:
            rarity: Card rarity (common, uncommon, rare, mythic)

        Returns:
            List of card dictionaries
        """
        if rarity not in self._card_pools:
            result = self.supabase.table("cards")\
                .select("*")\
                .eq("set_code", self.set_code)\
                .eq("rarity", rarity)\
                .execute()

            self._card_pools[rarity] = result.data

        return self._card_pools[rarity]

    def generate_booster(self) -> List[Dict]:
        """Generate a single 14-card booster pack.

        Rarity distribution:
        - 10 commons
        - 3 uncommons
        - 1 rare (or mythic with ~12.5% chance)

        Returns:
            List of 14 card dictionaries
        """
        booster = []

        commons = self._fetch_cards_by_rarity("common")
        if len(commons) >= 10:
            booster.extend(random.sample(commons, 10))
        else:
            print(f"⚠️  Not enough commons in {self.set_code}")

        uncommons = self._fetch_cards_by_rarity("uncommon")
        if len(uncommons) >= 3:
            booster.extend(random.sample(uncommons, 3))
        else:
            print(f"⚠️  Not enough uncommons in {self.set_code}")

        if random.random() < self.MYTHIC_RATE:
            mythics = self._fetch_cards_by_rarity("mythic")
            if mythics:
                booster.append(random.choice(mythics))
            else:
                rares = self._fetch_cards_by_rarity("rare")
                if rares:
                    booster.append(random.choice(rares))
        else:
            rares = self._fetch_cards_by_rarity("rare")
            if rares:
                booster.append(random.choice(rares))
            else:
                print(f"⚠️  No rares in {self.set_code}")

        random.shuffle(booster)
        return booster

    def generate_boosters(self, count: int) -> List[List[Dict]]:
        """Generate multiple booster packs.

        Args:
            count: Number of boosters to generate

        Returns:
            List of booster packs (each a list of cards)
        """
        return [self.generate_booster() for _ in range(count)]


def generate_draft_boosters(set_code: str, player_count: int, packs_per_player: int = 3) -> Dict[int, List[List[Dict]]]:
    """Generate all boosters needed for a draft.

    Args:
        set_code: Set code to draft
        player_count: Number of players
        packs_per_player: Packs per player (default 3)

    Returns:
        Dictionary mapping player seat -> list of booster packs
    """
    generator = BoosterGenerator(set_code)
    draft_boosters = {}

    total_packs = player_count * packs_per_player
    print(f"🎲 Generating {total_packs} boosters for {player_count} players from set {set_code.upper()}")

    for seat in range(player_count):
        draft_boosters[seat] = generator.generate_boosters(packs_per_player)

    print(f"✅ Generated {total_packs} boosters")
    return draft_boosters
