#!/usr/bin/env python3
"""Fast import using environment Supabase variables"""
import json
import os
from supabase import create_client

# Use environment variables
url = os.getenv('SUPABASE_URL', 'https://iqkokwgnqtyvmyyaqzex.supabase.co')
key = os.getenv('SUPABASE_ANON_KEY', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imlxa29rd2ducXR5dm15eWFxemV4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU4NjI0NTAsImV4cCI6MjA4MTQzODQ1MH0.ocIYIflmgEBGqC7A_rIs62TrNR3kJdIVSBaDngM46pY')

supabase = create_client(url, key)

# Load cards
with open('data/blb_cards.json') as f:
    cards = json.load(f)

print(f"Importing {len(cards)} cards...")

# Import in batches of 100
batch_size = 100
for i in range(0, len(cards), batch_size):
    batch = cards[i:i+batch_size]
    try:
        supabase.table('cards').upsert(batch).execute()
        print(f"✅ Imported {i+len(batch)}/{len(cards)}")
    except Exception as e:
        print(f"❌ Error at {i}: {e}")

print("Done!")
