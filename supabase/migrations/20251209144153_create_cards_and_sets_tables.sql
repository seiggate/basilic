/*
  # Create Cards and Sets System

  1. New Tables
    - `sets`
      - `code` (text, primary key) - Set code (e.g., 'khm', 'woe')
      - `name` (text) - Full set name
      - `release_date` (date) - Release date
      - `card_count` (integer) - Total cards in set
      - `icon_uri` (text) - Set icon URL
      - `created_at` (timestamptz)
    
    - `cards`
      - `id` (uuid, primary key) - Scryfall card ID
      - `name` (text) - Card name
      - `mana_cost` (text) - Mana cost
      - `cmc` (numeric) - Converted mana cost
      - `type_line` (text) - Type line
      - `oracle_text` (text) - Card text
      - `colors` (text[]) - Color array
      - `rarity` (text) - common, uncommon, rare, mythic
      - `set_code` (text) - Foreign key to sets
      - `collector_number` (text) - Collector number
      - `image_uri` (text) - Image URL
      - `image_uri_small` (text) - Small image URL
      - `prices` (jsonb) - Price data
      - `created_at` (timestamptz)

  2. Indexes
    - Index on cards.set_code for fast filtering
    - Index on cards.rarity for booster generation
    - Index on cards.name for search

  3. Security
    - Enable RLS on both tables
    - Public read access for all cards
    - No write access (cards managed via import scripts)
*/

-- Create sets table
CREATE TABLE IF NOT EXISTS sets (
  code text PRIMARY KEY,
  name text NOT NULL,
  release_date date,
  card_count integer DEFAULT 0,
  icon_uri text,
  created_at timestamptz DEFAULT now()
);

-- Create cards table
CREATE TABLE IF NOT EXISTS cards (
  id uuid PRIMARY KEY,
  name text NOT NULL,
  mana_cost text,
  cmc numeric DEFAULT 0,
  type_line text,
  oracle_text text,
  colors text[],
  rarity text NOT NULL CHECK (rarity IN ('common', 'uncommon', 'rare', 'mythic')),
  set_code text NOT NULL REFERENCES sets(code) ON DELETE CASCADE,
  collector_number text,
  image_uri text,
  image_uri_small text,
  prices jsonb,
  created_at timestamptz DEFAULT now()
);

-- Create indexes
CREATE INDEX IF NOT EXISTS idx_cards_set_code ON cards(set_code);
CREATE INDEX IF NOT EXISTS idx_cards_rarity ON cards(rarity);
CREATE INDEX IF NOT EXISTS idx_cards_name ON cards(name);
CREATE INDEX IF NOT EXISTS idx_cards_set_rarity ON cards(set_code, rarity);

-- Enable RLS
ALTER TABLE sets ENABLE ROW LEVEL SECURITY;
ALTER TABLE cards ENABLE ROW LEVEL SECURITY;

-- Sets policies: everyone can read
CREATE POLICY "Anyone can view sets"
  ON sets FOR SELECT
  USING (true);

-- Cards policies: everyone can read
CREATE POLICY "Anyone can view cards"
  ON cards FOR SELECT
  USING (true);

-- Add set_code to lobbies table
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'lobbies' AND column_name = 'set_code'
  ) THEN
    ALTER TABLE lobbies ADD COLUMN set_code text DEFAULT 'khm';
  END IF;
END $$;

-- Add last_activity column if not exists
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'lobbies' AND column_name = 'last_activity'
  ) THEN
    ALTER TABLE lobbies ADD COLUMN last_activity timestamptz DEFAULT now();
  END IF;
END $$;
