═══════════════════════════════════════════════════════════
    GUIDE RAPIDE : CRÉER L'EXÉCUTABLE BASILIC
═══════════════════════════════════════════════════════════

┌─────────────────────────────────────────────────────────┐
│  ÉTAPE 1 : INSTALLER LES DÉPENDANCES                   │
└─────────────────────────────────────────────────────────┘

Dans un terminal, tapez :

    pip install -r requirements.txt


┌─────────────────────────────────────────────────────────┐
│  ÉTAPE 2 : LANCER LE BUILD                             │
└─────────────────────────────────────────────────────────┘

Sur Windows :
    Double-cliquez sur → build.bat

Sur Linux/Mac :
    ./build.sh

OU manuellement :
    python build_exe.py


┌─────────────────────────────────────────────────────────┐
│  ÉTAPE 3 : RÉCUPÉRER L'EXÉCUTABLE                      │
└─────────────────────────────────────────────────────────┘

Votre exécutable se trouve dans :
    dist/Basilic.exe  (Windows)
    dist/Basilic      (Linux/Mac)


┌─────────────────────────────────────────────────────────┐
│  ÉTAPE 4 : DISTRIBUER L'APPLICATION                    │
└─────────────────────────────────────────────────────────┘

Pour partager votre application, créez un dossier avec :

    Basilic/
    ├── Basilic.exe    ← L'exécutable
    └── .env           ← Fichier de configuration Supabase

⚠️  IMPORTANT : Le fichier .env DOIT être présent !


═══════════════════════════════════════════════════════════
    DÉPANNAGE RAPIDE
═══════════════════════════════════════════════════════════

❌ "PyInstaller n'est pas installé"
   → pip install pyinstaller

❌ L'exécutable ne se lance pas
   → Vérifiez que le .env est à côté de l'exe
   → Lancez l'exe depuis un terminal pour voir les erreurs

❌ L'antivirus bloque l'exécutable
   → C'est normal avec PyInstaller
   → Ajoutez une exception dans l'antivirus


═══════════════════════════════════════════════════════════

Pour plus de détails, consultez BUILD_README.md
