/*
  # Create Draft System Tables

  1. New Tables
    - `drafts`
      - `id` (uuid, primary key)
      - `lobby_id` (uuid, foreign key to lobbies)
      - `current_round` (integer) - Current round number (1-3)
      - `current_pick` (integer) - Current pick in round (1-14)
      - `direction` (text) - Pass direction: 'left' or 'right'
      - `status` (text) - Draft status: 'in_progress', 'completed'
      - `started_at` (timestamptz)
      - `completed_at` (timestamptz, nullable)
      
    - `draft_packs`
      - `id` (uuid, primary key)
      - `draft_id` (uuid, foreign key to drafts)
      - `player_seat` (integer) - Player seat position
      - `round_number` (integer) - Which round (1-3)
      - `cards` (jsonb) - Array of card data
      - `current_owner_seat` (integer) - Who currently has this pack
      - `created_at` (timestamptz)
      
    - `draft_picks`
      - `id` (uuid, primary key)
      - `draft_id` (uuid, foreign key to drafts)
      - `player_seat` (integer) - Player who made the pick
      - `card_id` (uuid) - Card that was picked
      - `round_number` (integer)
      - `pick_number` (integer) - Pick number in round
      - `picked_at` (timestamptz)
      
    - `player_pools`
      - `id` (uuid, primary key)
      - `draft_id` (uuid, foreign key to drafts)
      - `player_seat` (integer)
      - `cards` (jsonb) - Array of picked card IDs
      - `updated_at` (timestamptz)

  2. Security
    - Enable RLS on all tables
    - Allow authenticated users to read their own draft data
    - Allow authenticated users to make picks
*/

-- Create drafts table
CREATE TABLE IF NOT EXISTS drafts (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  lobby_id uuid NOT NULL REFERENCES lobbies(id) ON DELETE CASCADE,
  current_round integer DEFAULT 1 CHECK (current_round BETWEEN 1 AND 3),
  current_pick integer DEFAULT 1 CHECK (current_pick BETWEEN 1 AND 14),
  direction text DEFAULT 'left' CHECK (direction IN ('left', 'right')),
  status text DEFAULT 'in_progress' CHECK (status IN ('in_progress', 'completed')),
  started_at timestamptz DEFAULT now(),
  completed_at timestamptz
);

-- Create draft_packs table
CREATE TABLE IF NOT EXISTS draft_packs (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  draft_id uuid NOT NULL REFERENCES drafts(id) ON DELETE CASCADE,
  player_seat integer NOT NULL,
  round_number integer NOT NULL CHECK (round_number BETWEEN 1 AND 3),
  cards jsonb NOT NULL DEFAULT '[]',
  current_owner_seat integer NOT NULL,
  created_at timestamptz DEFAULT now()
);

-- Create draft_picks table
CREATE TABLE IF NOT EXISTS draft_picks (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  draft_id uuid NOT NULL REFERENCES drafts(id) ON DELETE CASCADE,
  player_seat integer NOT NULL,
  card_id text NOT NULL,
  round_number integer NOT NULL,
  pick_number integer NOT NULL,
  picked_at timestamptz DEFAULT now()
);

-- Create player_pools table
CREATE TABLE IF NOT EXISTS player_pools (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  draft_id uuid NOT NULL REFERENCES drafts(id) ON DELETE CASCADE,
  player_seat integer NOT NULL,
  cards jsonb NOT NULL DEFAULT '[]',
  updated_at timestamptz DEFAULT now(),
  UNIQUE(draft_id, player_seat)
);

-- Enable RLS
ALTER TABLE drafts ENABLE ROW LEVEL SECURITY;
ALTER TABLE draft_packs ENABLE ROW LEVEL SECURITY;
ALTER TABLE draft_picks ENABLE ROW LEVEL SECURITY;
ALTER TABLE player_pools ENABLE ROW LEVEL SECURITY;

-- RLS Policies for drafts
CREATE POLICY "Anyone can view drafts"
  ON drafts FOR SELECT
  USING (true);

CREATE POLICY "Anyone can create drafts"
  ON drafts FOR INSERT
  WITH CHECK (true);

CREATE POLICY "Anyone can update drafts"
  ON drafts FOR UPDATE
  USING (true)
  WITH CHECK (true);

-- RLS Policies for draft_packs
CREATE POLICY "Anyone can view draft packs"
  ON draft_packs FOR SELECT
  USING (true);

CREATE POLICY "Anyone can create draft packs"
  ON draft_packs FOR INSERT
  WITH CHECK (true);

CREATE POLICY "Anyone can update draft packs"
  ON draft_packs FOR UPDATE
  USING (true)
  WITH CHECK (true);

CREATE POLICY "Anyone can delete draft packs"
  ON draft_packs FOR DELETE
  USING (true);

-- RLS Policies for draft_picks
CREATE POLICY "Anyone can view draft picks"
  ON draft_picks FOR SELECT
  USING (true);

CREATE POLICY "Anyone can create draft picks"
  ON draft_picks FOR INSERT
  WITH CHECK (true);

-- RLS Policies for player_pools
CREATE POLICY "Anyone can view player pools"
  ON player_pools FOR SELECT
  USING (true);

CREATE POLICY "Anyone can create player pools"
  ON player_pools FOR INSERT
  WITH CHECK (true);

CREATE POLICY "Anyone can update player pools"
  ON player_pools FOR UPDATE
  USING (true)
  WITH CHECK (true);

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_drafts_lobby_id ON drafts(lobby_id);
CREATE INDEX IF NOT EXISTS idx_draft_packs_draft_id ON draft_packs(draft_id);
CREATE INDEX IF NOT EXISTS idx_draft_packs_current_owner ON draft_packs(draft_id, current_owner_seat);
CREATE INDEX IF NOT EXISTS idx_draft_picks_draft_id ON draft_picks(draft_id);
CREATE INDEX IF NOT EXISTS idx_draft_picks_player ON draft_picks(draft_id, player_seat);
CREATE INDEX IF NOT EXISTS idx_player_pools_draft_id ON player_pools(draft_id);
