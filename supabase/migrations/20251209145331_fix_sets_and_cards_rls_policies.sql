/*
  # Fix RLS Policies for Sets and Cards Tables

  1. Changes
    - Add INSERT policies for sets and cards tables
    - Allow anyone to insert sets and cards (needed for import scripts)
    
  2. Security Notes
    - These policies allow public write access for data import
    - In production, you may want to restrict this to service role only
    - For now, allowing public insert for easier data management
*/

-- Drop existing policies
DROP POLICY IF EXISTS "Anyone can view sets" ON sets;
DROP POLICY IF EXISTS "Anyone can view cards" ON cards;

-- Recreate read policies
CREATE POLICY "Anyone can view sets"
  ON sets FOR SELECT
  USING (true);

CREATE POLICY "Anyone can view cards"
  ON cards FOR SELECT
  USING (true);

-- Add insert policies for data import
CREATE POLICY "Anyone can insert sets"
  ON sets FOR INSERT
  WITH CHECK (true);

CREATE POLICY "Anyone can insert cards"
  ON cards FOR INSERT
  WITH CHECK (true);
