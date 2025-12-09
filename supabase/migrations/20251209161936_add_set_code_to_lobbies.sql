/*
  # Add set selection to lobbies

  1. Changes
    - Add `set_code` column to `lobbies` table to store the selected Magic set
    - Defaults to 'blb' (Bloomburrow) for existing lobbies
  
  2. Purpose
    - Allow lobby creators to choose which Magic set to draft from
    - This will be used when generating booster packs for the draft
*/

-- Add set_code column to lobbies table
ALTER TABLE lobbies ADD COLUMN IF NOT EXISTS set_code text DEFAULT 'blb' NOT NULL;

-- Add foreign key constraint to ensure valid set codes
ALTER TABLE lobbies 
  DROP CONSTRAINT IF EXISTS lobbies_set_code_fkey;

ALTER TABLE lobbies 
  ADD CONSTRAINT lobbies_set_code_fkey 
  FOREIGN KEY (set_code) 
  REFERENCES sets(code);
