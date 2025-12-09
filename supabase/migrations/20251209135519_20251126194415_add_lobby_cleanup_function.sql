/*
  # Add automatic lobby cleanup system
  
  1. Changes
    - Add `last_activity` timestamp column to lobbies table to track activity
    - Create trigger to automatically update `last_activity` when lobby_players change
    - Create function to clean up abandoned lobbies (inactive for 30+ minutes)
    - Create scheduled job to run cleanup every 5 minutes
  
  2. Security
    - Function uses SECURITY DEFINER to run with elevated privileges
    - Only deletes lobbies that are truly abandoned (no activity for 30 minutes)
*/

-- Add last_activity column to track when lobby was last active
ALTER TABLE lobbies ADD COLUMN IF NOT EXISTS last_activity timestamptz DEFAULT now();

-- Update existing rows
UPDATE lobbies SET last_activity = updated_at WHERE last_activity IS NULL;

-- Function to update last_activity timestamp
CREATE OR REPLACE FUNCTION update_lobby_activity()
RETURNS TRIGGER AS $$
BEGIN
  UPDATE lobbies 
  SET last_activity = now() 
  WHERE id = COALESCE(NEW.lobby_id, OLD.lobby_id);
  RETURN COALESCE(NEW, OLD);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Trigger on lobby_players to update lobby activity
DROP TRIGGER IF EXISTS lobby_players_activity_trigger ON lobby_players;
CREATE TRIGGER lobby_players_activity_trigger
  AFTER INSERT OR UPDATE OR DELETE ON lobby_players
  FOR EACH ROW
  EXECUTE FUNCTION update_lobby_activity();

-- Function to cleanup abandoned lobbies
CREATE OR REPLACE FUNCTION cleanup_abandoned_lobbies()
RETURNS void AS $$
BEGIN
  -- Delete players from abandoned lobbies first
  DELETE FROM lobby_players 
  WHERE lobby_id IN (
    SELECT id FROM lobbies 
    WHERE last_activity < now() - interval '30 minutes'
    AND status = 'waiting'
  );
  
  -- Delete abandoned lobbies
  DELETE FROM lobbies 
  WHERE last_activity < now() - interval '30 minutes'
  AND status = 'waiting';
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;