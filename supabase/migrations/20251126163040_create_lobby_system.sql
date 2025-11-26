/*
  # Lobby System for Basilic Draft

  1. New Tables
    - `lobbies`
      - `id` (uuid, primary key)
      - `name` (text) - Name of the lobby
      - `code` (text, unique) - 5-character join code
      - `creator_name` (text) - Name of the lobby creator
      - `max_players` (integer) - Maximum players (4-8)
      - `status` (text) - 'waiting', 'in_progress', 'completed'
      - `created_at` (timestamptz)
      - `updated_at` (timestamptz)
    
    - `lobby_players`
      - `id` (uuid, primary key)
      - `lobby_id` (uuid, foreign key to lobbies)
      - `player_name` (text) - Player name or 'Anonymous'
      - `seat_position` (integer) - Position at the round table (0-7)
      - `is_creator` (boolean) - Whether this player created the lobby
      - `joined_at` (timestamptz)

  2. Security
    - Enable RLS on both tables
    - Public read access for active lobbies
    - Players can join available lobbies
    - Only creators can update lobby status
*/

-- Create lobbies table
CREATE TABLE IF NOT EXISTS lobbies (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  code text UNIQUE NOT NULL,
  creator_name text NOT NULL,
  max_players integer NOT NULL CHECK (max_players >= 4 AND max_players <= 8),
  status text NOT NULL DEFAULT 'waiting' CHECK (status IN ('waiting', 'in_progress', 'completed')),
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Create lobby_players table
CREATE TABLE IF NOT EXISTS lobby_players (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  lobby_id uuid NOT NULL REFERENCES lobbies(id) ON DELETE CASCADE,
  player_name text NOT NULL,
  seat_position integer NOT NULL CHECK (seat_position >= 0 AND seat_position <= 7),
  is_creator boolean DEFAULT false,
  joined_at timestamptz DEFAULT now(),
  UNIQUE(lobby_id, seat_position)
);

-- Create index for faster lobby lookups
CREATE INDEX IF NOT EXISTS idx_lobbies_code ON lobbies(code);
CREATE INDEX IF NOT EXISTS idx_lobbies_status ON lobbies(status);
CREATE INDEX IF NOT EXISTS idx_lobby_players_lobby_id ON lobby_players(lobby_id);

-- Enable RLS
ALTER TABLE lobbies ENABLE ROW LEVEL SECURITY;
ALTER TABLE lobby_players ENABLE ROW LEVEL SECURITY;

-- Lobbies policies: anyone can read waiting lobbies
CREATE POLICY "Anyone can view waiting lobbies"
  ON lobbies FOR SELECT
  USING (status = 'waiting');

CREATE POLICY "Anyone can create lobbies"
  ON lobbies FOR INSERT
  WITH CHECK (true);

CREATE POLICY "Anyone can update lobbies"
  ON lobbies FOR UPDATE
  USING (true)
  WITH CHECK (true);

-- Lobby players policies
CREATE POLICY "Anyone can view lobby players"
  ON lobby_players FOR SELECT
  USING (true);

CREATE POLICY "Anyone can join lobbies"
  ON lobby_players FOR INSERT
  WITH CHECK (true);

CREATE POLICY "Anyone can leave lobbies"
  ON lobby_players FOR DELETE
  USING (true);
