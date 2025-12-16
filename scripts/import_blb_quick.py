#!/usr/bin/env python3
"""
Quick import of BLB cards from JSON to Supabase
"""
import json
import sys
from pathlib import Path

# Add parent to path
sys.path.insert(0, str(Path(__file__).parent.parent / "client_py"))

from core.supabase_client import get_supabase_client

def main():
    print("🚀 Import rapide des cartes BLB dans Supabase")

    # Load JSON
    json_path = Path(__file__).parent.parent / "data" / "blb_cards.json"
    with open(json_path) as f:
        cards = json.load(f)

    print(f"📦 {len(cards)} cartes à importer")

    # Get Supabase client
    supabase = get_supabase_client()
    if not supabase:
        print("❌ Impossible de se connecter à Supabase")
        return

    print("✅ Connecté à Supabase")

    # Import in batches of 50
    batch_size = 50
    for i in range(0, len(cards), batch_size):
        batch = cards[i:i+batch_size]
        try:
            supabase.table('cards').upsert(batch).execute()
            print(f"✅ Lot {i//batch_size + 1}/{(len(cards)-1)//batch_size + 1} importé ({len(batch)} cartes)")
        except Exception as e:
            print(f"❌ Erreur lot {i//batch_size + 1}: {e}")

    print(f"\n🎉 Import terminé ! {len(cards)} cartes dans Supabase")

if __name__ == "__main__":
    main()
