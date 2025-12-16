#!/usr/bin/env python3
"""
Import multiple sets from Scryfall to Supabase
Downloads and imports cards from BLB, MKM, and NEO sets
"""
import json
import os
import time
import requests
from supabase import create_client

# Supabase configuration
url = os.getenv('SUPABASE_URL', 'https://iqkokwgnqtyvmyyaqzex.supabase.co')
key = os.getenv('SUPABASE_ANON_KEY', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imlxa29rd2ducXR5dm15eWFxemV4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU4NjI0NTAsImV4cCI6MjA4MTQzODQ1MH0.ocIYIflmgEBGqC7A_rIs62TrNR3kJdIVSBaDngM46pY')

supabase = create_client(url, key)

# Sets to import
SETS = ['blb', 'mkm', 'neo']

def get_set_info(set_code):
    """Get set information from Scryfall API"""
    url = f"https://api.scryfall.com/sets/{set_code}"
    response = requests.get(url)
    if response.status_code != 200:
        print(f"⚠️  Could not get set info for {set_code.upper()}")
        return None

    data = response.json()
    return {
        'code': data['code'],
        'name': data['name'],
        'release_date': data.get('released_at', '2000-01-01'),
        'card_count': data.get('card_count', 0),
        'icon_uri': data.get('icon_svg_uri')
    }

def create_set(set_info):
    """Create set entry in database"""
    try:
        supabase.table('sets').upsert(set_info, on_conflict='code').execute()
        print(f"✅ Set {set_info['code'].upper()} created: {set_info['name']}")
        return True
    except Exception as e:
        print(f"❌ Error creating set: {e}")
        return False

def download_set(set_code):
    """Download all cards from a set using Scryfall API"""
    print(f"\n📥 Downloading {set_code.upper()}...")

    url = f"https://api.scryfall.com/cards/search?q=set:{set_code}&unique=prints"
    cards = []

    while url:
        response = requests.get(url)
        if response.status_code != 200:
            print(f"❌ Error: {response.status_code}")
            return []

        data = response.json()

        for card in data.get('data', []):
            # Skip tokens and special cards
            if card.get('layout') in ['token', 'emblem', 'art_series']:
                continue

            # Get image URIs
            image_uris = card.get('image_uris', {})
            if not image_uris and 'card_faces' in card:
                image_uris = card['card_faces'][0].get('image_uris', {})

            cards.append({
                'id': card['id'],
                'name': card['name'],
                'mana_cost': card.get('mana_cost'),
                'cmc': card.get('cmc', 0),
                'type_line': card.get('type_line', ''),
                'oracle_text': card.get('oracle_text'),
                'colors': card.get('colors', []),
                'rarity': card.get('rarity', 'common'),
                'set_code': card.get('set', set_code),
                'collector_number': card.get('collector_number', ''),
                'image_uri': image_uris.get('normal'),
                'image_uri_small': image_uris.get('small')
            })

        url = data.get('next_page')
        if url:
            time.sleep(0.1)  # Rate limiting

    print(f"✅ Downloaded {len(cards)} cards from {set_code.upper()}")
    return cards

def import_cards(cards, set_code):
    """Import cards to Supabase in batches"""
    print(f"\n📤 Importing {len(cards)} cards from {set_code.upper()}...")

    batch_size = 100
    imported = 0

    for i in range(0, len(cards), batch_size):
        batch = cards[i:i+batch_size]
        try:
            supabase.table('cards').upsert(batch, on_conflict='id').execute()
            imported += len(batch)
            print(f"  ✓ {imported}/{len(cards)} cards imported")
        except Exception as e:
            print(f"  ❌ Error at batch {i}: {e}")
            continue

    return imported

def main():
    print("=" * 60)
    print("IMPORTING CARDS FROM SCRYFALL TO SUPABASE")
    print("=" * 60)
    print(f"Sets: {', '.join([s.upper() for s in SETS])}")

    total_downloaded = 0
    total_imported = 0

    for set_code in SETS:
        print(f"\n{'=' * 60}")
        print(f"PROCESSING SET: {set_code.upper()}")
        print('=' * 60)

        # Get and create set info first
        set_info = get_set_info(set_code)
        if not set_info:
            print(f"⚠️  Skipping {set_code.upper()} - could not get set info")
            continue

        if not create_set(set_info):
            print(f"⚠️  Skipping {set_code.upper()} - could not create set entry")
            continue

        # Download cards
        cards = download_set(set_code)
        if not cards:
            print(f"⚠️  Skipping {set_code.upper()} - no cards downloaded")
            continue

        total_downloaded += len(cards)

        # Import to database
        imported = import_cards(cards, set_code)
        total_imported += imported

        # Save to JSON file for backup
        filename = f"data/{set_code}_cards.json"
        os.makedirs('data', exist_ok=True)
        with open(filename, 'w', encoding='utf-8') as f:
            json.dump(cards, f, indent=2, ensure_ascii=False)
        print(f"💾 Saved to {filename}")

    print("\n" + "=" * 60)
    print(f"✅ COMPLETE!")
    print(f"Downloaded: {total_downloaded} cards")
    print(f"Imported: {total_imported} cards")
    print("=" * 60)

if __name__ == '__main__':
    main()
