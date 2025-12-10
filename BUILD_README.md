# Guide de création de l'exécutable Basilic

## Méthode la plus simple

### Sur Windows
Double-cliquez sur `build.bat`

### Sur Linux/Mac
```bash
./build.sh
```

L'exécutable sera créé dans le dossier `dist/`

## Prérequis

Assurez-vous d'avoir installé toutes les dépendances :
```bash
pip install -r requirements.txt
```

## Fichiers créés

Après le build, vous trouverez :
- `dist/Basilic.exe` (Windows) ou `dist/Basilic` (Linux/Mac) - L'application
- `build/` - Fichiers temporaires (peut être supprimé)
- `Basilic.spec` - Configuration PyInstaller

## Distribution de l'application

Pour distribuer votre application :

1. **Copiez ces fichiers :**
   - `dist/Basilic.exe` (ou `Basilic` sur Linux/Mac)
   - Le fichier `.env` avec vos clés Supabase

2. **Structure recommandée :**
   ```
   Basilic/
   ├── Basilic.exe
   └── .env
   ```

3. **Envoyez le dossier complet** à vos utilisateurs

## Important

⚠️ **Le fichier .env est nécessaire** pour que l'application se connecte à Supabase. Il doit être dans le même dossier que l'exécutable.

⚠️ **Ne commitez JAMAIS le .env** sur GitHub ou autre système de contrôle de version public.

## Taille de l'exécutable

L'exécutable fera environ **60-90 MB** car il inclut :
- Python runtime
- PySide6 (Qt)
- Toutes les bibliothèques nécessaires

## Options avancées

Si vous voulez personnaliser le build, modifiez `basilic.spec` puis exécutez :
```bash
pyinstaller basilic.spec
```

### Options utiles dans basilic.spec :
- `console=True` : Affiche une console (utile pour le debug)
- `icon='icon.ico'` : Ajoute une icône personnalisée
- `upx=True` : Compresse l'exécutable (réduit la taille)

## Dépannage

### L'exécutable ne démarre pas
1. Essayez de le lancer depuis un terminal pour voir les erreurs
2. Vérifiez que le fichier `.env` est présent
3. Vérifiez que toutes les dépendances étaient installées lors du build

### "Module not found"
Ajoutez le module manquant dans `hiddenimports` du fichier `basilic.spec`

### Antivirus bloque l'exécutable
C'est normal, les exécutables PyInstaller sont parfois signalés. Vous pouvez :
- Signer l'exécutable avec un certificat
- Ajouter une exception dans l'antivirus
- Utiliser `--onedir` au lieu de `--onefile` (crée un dossier au lieu d'un seul fichier)

## Build multi-plateforme

⚠️ **Important :** PyInstaller crée des exécutables **spécifiques à la plateforme**.

- Pour créer un .exe Windows : buildez sur Windows
- Pour créer un exécutable Mac : buildez sur Mac
- Pour créer un exécutable Linux : buildez sur Linux

Il n'est pas possible de créer un .exe Windows depuis Linux ou Mac.
