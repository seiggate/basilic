# Instructions pour créer l'exécutable Basilic

## Prérequis

1. Installer PyInstaller :
```bash
pip install pyinstaller
```

## Méthode 1 : Build automatique (recommandé)

Exécutez simplement :
```bash
python build_exe.py
```

L'exécutable sera créé dans le dossier `dist/Basilic.exe`

## Méthode 2 : Build manuel avec PyInstaller

```bash
pyinstaller --name=Basilic --onefile --windowed --add-data=".env;." --add-data="client_py/ui;ui" client_py/main.py
```

### Options expliquées :
- `--name=Basilic` : Nom de l'exécutable
- `--onefile` : Créer un seul fichier .exe (tout inclus)
- `--windowed` : Pas de console DOS en arrière-plan
- `--add-data` : Inclure les fichiers .env et UI
- `--clean` : Nettoyer les fichiers temporaires
- `--noconfirm` : Ne pas demander de confirmation

## Méthode 3 : Build avec fichier .spec personnalisé

Si vous voulez plus de contrôle, utilisez :
```bash
pyinstaller basilic.spec
```

## Distribution

Une fois l'exécutable créé, vous devez distribuer :
1. `dist/Basilic.exe` - L'application
2. Le fichier `.env` avec les clés Supabase (à côté de l'exe)

⚠️ **Important** : L'exécutable doit avoir accès au fichier `.env` pour se connecter à Supabase.

## Taille de l'exécutable

L'exécutable fera environ 50-80 MB car il inclut Python, PySide6 et toutes les dépendances.

## Dépannage

Si l'exécutable ne se lance pas :
1. Essayez sans `--windowed` pour voir les erreurs dans la console
2. Vérifiez que toutes les dépendances sont installées
3. Consultez le fichier de log dans `build/Basilic/`
