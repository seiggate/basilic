# Guide de Distribution de Basilic

## Préparation de la distribution

Une fois l'exécutable créé, voici comment préparer l'application pour la distribution.

### Structure recommandée

```
Basilic-v1.0/
├── Basilic.exe          # L'application
├── .env                 # Configuration Supabase
└── README.txt           # Instructions pour l'utilisateur
```

### Fichier README.txt pour les utilisateurs

Créez un fichier `README.txt` avec ce contenu :

```
═══════════════════════════════════════════════════════════
    BASILIC - APPLICATION DE DRAFT MAGIC: THE GATHERING
═══════════════════════════════════════════════════════════

LANCEMENT DE L'APPLICATION
───────────────────────────
1. Double-cliquez sur Basilic.exe
2. L'application se lance automatiquement

FONCTIONNALITÉS
───────────────
• Bibliothèque de cartes Magic
• Générateur de boosters
• Simulation de draft solo
• Système de lobby multijoueur en ligne

CONFIGURATION REQUISE
─────────────────────
• Windows 10 ou supérieur
• Connexion internet (pour le mode multijoueur)
• 100 MB d'espace disque

DÉPANNAGE
─────────
Si l'application ne démarre pas :
1. Vérifiez que le fichier .env est présent
2. Vérifiez votre connexion internet
3. Autorisez l'application dans votre antivirus

SUPPORT
───────
Pour toute question ou problème :
• GitHub : [votre-repo]
• Email : [votre-email]

═══════════════════════════════════════════════════════════
```

## Options de distribution

### Option 1 : Fichier ZIP

```bash
# Créer une archive
zip -r Basilic-v1.0.zip Basilic.exe .env README.txt
```

### Option 2 : Installateur (Avancé)

Utilisez Inno Setup (Windows) ou create-dmg (Mac) pour créer un vrai installateur.

#### Avec Inno Setup (Windows)

1. Téléchargez Inno Setup : https://jrsoftware.org/isinfo.php
2. Créez un script `installer.iss` :

```iss
[Setup]
AppName=Basilic
AppVersion=1.0
DefaultDirName={pf}\Basilic
DefaultGroupName=Basilic
OutputBaseFilename=Basilic-Setup
Compression=lzma2
SolidCompression=yes

[Files]
Source: "dist\Basilic.exe"; DestDir: "{app}"
Source: ".env"; DestDir: "{app}"

[Icons]
Name: "{group}\Basilic"; Filename: "{app}\Basilic.exe"
Name: "{commondesktop}\Basilic"; Filename: "{app}\Basilic.exe"
```

3. Compilez avec Inno Setup

## Distribution publique

### ⚠️ ATTENTION - Sécurité

**NE DISTRIBUEZ JAMAIS votre fichier .env avec vos vraies clés !**

Au lieu de ça :

1. **Option A** : Chaque utilisateur doit créer son propre compte Supabase
   - Fournissez un fichier `.env.example`
   - Incluez les instructions pour obtenir les clés

2. **Option B** : Créez un backend séparé (recommandé pour production)
   - N'exposez jamais les clés Supabase côté client
   - Utilisez un serveur intermédiaire avec authentification

### Fichier .env.example

Créez un `.env.example` pour la distribution publique :

```env
# Configuration Supabase
# Obtenez vos clés sur : https://supabase.com/dashboard

SUPABASE_URL=votre_url_supabase_ici
SUPABASE_ANON_KEY=votre_cle_anonyme_ici

# Instructions :
# 1. Renommez ce fichier en .env
# 2. Créez un compte sur supabase.com
# 3. Créez un nouveau projet
# 4. Copiez vos clés depuis Settings > API
# 5. Remplacez les valeurs ci-dessus
```

## Distribution sur des plateformes

### GitHub Releases

1. Créez un tag de version :
```bash
git tag -a v1.0.0 -m "Version 1.0.0"
git push origin v1.0.0
```

2. Créez une release sur GitHub
3. Uploadez le fichier ZIP

### Alternatives

- **itch.io** : Parfait pour les applications gaming
- **Steam** : Pour une distribution large (payant)
- **Microsoft Store** : Demande certification

## Mise à jour automatique (Avancé)

Pour implémenter des mises à jour automatiques, considérez :
- **pyupdater** : Framework de mise à jour pour PyInstaller
- **GitHub Releases API** : Vérifier les nouvelles versions

## Checklist de distribution

Avant de distribuer :

- [ ] Testez l'exécutable sur une machine propre
- [ ] Vérifiez que le .env n'est PAS committé sur Git
- [ ] Créez un fichier README.txt pour les utilisateurs
- [ ] Testez sur différentes versions de Windows
- [ ] Vérifiez la taille du fichier (devrait être < 100 MB)
- [ ] Créez un fichier .env.example si distribution publique
- [ ] Documentez comment obtenir les clés Supabase
- [ ] Ajoutez des captures d'écran
- [ ] Incluez les informations de licence
- [ ] Testez l'installation complète

## Licence et légal

N'oubliez pas d'inclure :
- Un fichier `LICENSE` (MIT, GPL, etc.)
- Les mentions légales pour les cartes Magic (© Wizards of the Coast)
- Les crédits pour les bibliothèques utilisées
