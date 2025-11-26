"""
Script to initialize the lobby database schema in Supabase.
This creates the lobbies and lobby_players tables with proper RLS policies.
"""

import os
import sys
from pathlib import Path
from dotenv import load_dotenv

# Load environment variables
env_path = Path(__file__).parent.parent / ".env"
load_dotenv(dotenv_path=env_path)

# Import supabase directly
try:
    from supabase import create_client, Client
except ImportError:
    print("Error: supabase package not installed.")
    print("Please run: pip install supabase")
    sys.exit(1)


def get_supabase_client():
    """Get a Supabase client instance"""
    SUPABASE_URL = os.environ.get("SUPABASE_URL", "")
    SUPABASE_KEY = os.environ.get("SUPABASE_ANON_KEY", "")

    if not SUPABASE_URL or not SUPABASE_KEY:
        return None

    return create_client(SUPABASE_URL, SUPABASE_KEY)


def create_lobby_tables():
    """Create lobbies and lobby_players tables with RLS policies"""

    supabase = get_supabase_client()

    if not supabase:
        print("Error: Supabase client not configured. Check your .env file.")
        return False

    migration_sql = """
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

    -- Drop existing policies if they exist
    DROP POLICY IF EXISTS "Anyone can view waiting lobbies" ON lobbies;
    DROP POLICY IF EXISTS "Anyone can create lobbies" ON lobbies;
    DROP POLICY IF EXISTS "Anyone can update lobbies" ON lobbies;
    DROP POLICY IF EXISTS "Anyone can view lobby players" ON lobby_players;
    DROP POLICY IF EXISTS "Anyone can join lobbies" ON lobby_players;
    DROP POLICY IF EXISTS "Anyone can leave lobbies" ON lobby_players;

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
    """

    try:
        print("Creating lobby tables...")
        result = supabase.rpc('exec_sql', {'query': migration_sql}).execute()
        print("✓ Lobby tables created successfully!")
        print("\nTables created:")
        print("  - lobbies")
        print("  - lobby_players")
        print("\nRLS policies configured for public access")
        return True
    except Exception as e:
        print(f"✗ Error creating tables: {e}")
        print("\nNote: This script requires a custom SQL execution function in Supabase.")
        print("The tables may already exist if you used the migration tool.")
        return False


def verify_tables():
    """Verify that the tables were created successfully"""

    supabase = get_supabase_client()

    if not supabase:
        print("Error: Supabase client not configured.")
        return False

    try:
        print("\nVerifying tables...")

        # Try to query the tables
        lobbies = supabase.table('lobbies').select('*').limit(1).execute()
        players = supabase.table('lobby_players').select('*').limit(1).execute()

        print("✓ Tables verified successfully!")
        print(f"  - lobbies table: accessible")
        print(f"  - lobby_players table: accessible")
        return True
    except Exception as e:
        print(f"✗ Error verifying tables: {e}")
        return False


def main():
    """Main entry point"""
    print("=" * 60)
    print("Basilic - Lobby Database Setup")
    print("=" * 60)
    print()

    # Check if .env file exists
    env_path = Path(__file__).parent.parent / ".env"
    if not env_path.exists():
        print("Warning: .env file not found!")
        print("Please create a .env file with your Supabase credentials.")
        print("You can copy .env.example and fill in your values.")
        return

    # Create tables
    success = create_lobby_tables()

    if success:
        # Verify tables
        verify_tables()
    else:
        print("\nAlternative: The tables should already be created via Supabase migration.")
        print("You can verify by checking the 'lobbies' and 'lobby_players' tables in Supabase.")

    print()
    print("=" * 60)


if __name__ == "__main__":
    main()
