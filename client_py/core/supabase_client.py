# client_py/core/supabase_client.py
import os
import sys
from pathlib import Path
from dotenv import load_dotenv
from supabase import create_client, Client

# Gestion des chemins pour PyInstaller
if getattr(sys, 'frozen', False):
    # Mode exécutable PyInstaller
    base_path = Path(sys._MEIPASS)
    env_path = base_path / ".env"
else:
    # Mode développement
    env_path = Path(__file__).parent.parent.parent / ".env"

load_dotenv(dotenv_path=env_path)

SUPABASE_URL = os.environ.get("SUPABASE_URL", "")
SUPABASE_KEY = os.environ.get("SUPABASE_ANON_KEY", "")

supabase: Client = None

def get_supabase_client():
    global supabase
    if supabase is None and SUPABASE_URL and SUPABASE_KEY:
        try:
            supabase = create_client(SUPABASE_URL, SUPABASE_KEY)
            # Test la connexion
            supabase.table('sets').select('code').limit(1).execute()
            return supabase
        except Exception as e:
            print(f"⚠️ Impossible de se connecter à Supabase: {e}")
            supabase = None
            return None
    return supabase
