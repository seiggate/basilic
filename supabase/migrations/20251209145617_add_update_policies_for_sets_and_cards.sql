/*
  # Add UPDATE Policies for Sets and Cards

  1. Changes
    - Add UPDATE policies for sets and cards tables
    - Allows upsert operations (used by import script)
    
  2. Security Notes
    - Enables public update for data management
    - In production, restrict to service role only
*/

-- Add update policies for data import
CREATE POLICY "Anyone can update sets"
  ON sets FOR UPDATE
  USING (true)
  WITH CHECK (true);

CREATE POLICY "Anyone can update cards"
  ON cards FOR UPDATE
  USING (true)
  WITH CHECK (true);
