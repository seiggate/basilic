# Guide de Test - Basilic C++

## Installation des Prérequis (Windows)

### 1. Installer Qt6

**Option A : Avec l'installateur officiel (Recommandé)**

1. Télécharger Qt : https://www.qt.io/download-qt-installer
2. Lancer l'installateur
3. Créer un compte Qt (gratuit)
4. Sélectionner ces composants :
   - Qt 6.x.x → Desktop gcc/MinGW
   - Qt 6.x.x → Sources
   - Developer and Designer Tools → CMake
   - Developer and Designer Tools → MinGW 13.1.0
5. Installation (environ 5-10 GB)
6. Chemin d'installation par défaut : `C:\Qt`

**Option B : Avec winget**
```bash
winget install -e --id Qt.Qt
```

### 2. Vérifier l'installation

Ouvrir un nouveau terminal (cmd) et taper :

```bash
# Vérifier Qt
dir C:\Qt\Tools\CMake_64\bin\cmake.exe
dir C:\Qt\Tools\mingw1310_64\bin\g++.exe
dir C:\Qt\6.7.0\mingw_64\bin\qmake.exe
```

**Note:** Les versions peuvent différer (6.7.0, mingw1310, etc.)

### 3. Ajouter Qt au PATH

**Méthode manuelle :**
1. Ouvrir "Variables d'environnement"
2. Ajouter au PATH :
   - `C:\Qt\Tools\CMake_64\bin`
   - `C:\Qt\Tools\mingw1310_64\bin`
   - `C:\Qt\6.7.0\mingw_64\bin`

**Méthode automatique (pour la session actuelle) :**
```bash
set "PATH=C:\Qt\Tools\CMake_64\bin;C:\Qt\Tools\mingw1310_64\bin;C:\Qt\6.7.0\mingw_64\bin;%PATH%"
```

### 4. Vérifier que tout fonctionne

```bash
cmake --version
g++ --version
qmake --version
```

Vous devriez voir les versions de chaque outil.

---

## Tester le Client Supabase

### Option 1 : Script automatique (plus simple)

```bash
cd client_cpp
test_managers.bat
```

### Option 2 : Commandes manuelles (si le script ne marche pas)

```bash
cd client_cpp

# Créer le dossier de build
mkdir build_test_mgr
cd build_test_mgr

# Configuration CMake
cmake .. -G "MinGW Makefiles" -DCMAKE_PREFIX_PATH=C:\Qt\6.7.0\mingw_64

# Compilation
cmake --build . --target test_managers

# Exécution
test_managers.exe
```

---

## Ce que le test va faire

Le programme `test_managers.exe` va :
1. ✅ Se connecter à Supabase
2. ✅ Charger les sets disponibles
3. ✅ Lister les lobbies en attente
4. ✅ Afficher les résultats

**Résultat attendu :**
```
==================================
Testing Basilic C++ Managers
==================================

Configuration loaded:
  Supabase URL: https://...
  API Key length: 200 chars

=== Test Supabase Connection ===
Client initialized: true

=== Test DatabaseManager ===
Loaded 50 sets
First set: Dominaria (DOM)

=== Test LobbyManager ===
Found 2 waiting lobbies
  - Mon Draft (ABC123) 3/8 players
  - Test Lobby (XYZ789) 1/8 players

Running tests... (will exit in 5 seconds)
```

---

## Problèmes Courants

### ❌ "cmake: command not found"
**Solution :** Ajouter CMake au PATH (voir étape 3)

### ❌ "Qt6 not found"
**Solution :** Spécifier le chemin Qt :
```bash
cmake .. -DCMAKE_PREFIX_PATH=C:\Qt\6.7.0\mingw_64
```

### ❌ "mingw32-make not found"
**Solution :** Vérifier que MinGW est dans le PATH :
```bash
set "PATH=C:\Qt\Tools\mingw1310_64\bin;%PATH%"
```

### ❌ "Failed to load configuration"
**Solution :** Vérifier que le fichier `.env` existe à la racine du projet avec :
```
VITE_SUPABASE_URL=https://...
VITE_SUPABASE_SUPABASE_ANON_KEY=...
```

---

## Alternative : Visual Studio

Si vous avez Visual Studio 2022 installé :

```bash
cd client_cpp
mkdir build_vs
cd build_vs
cmake .. -G "Visual Studio 17 2022" -DCMAKE_PREFIX_PATH=C:\Qt\6.7.0\msvc2019_64
cmake --build . --config Release
cd Release
test_managers.exe
```

---

## Prochaines Étapes

Une fois que les tests passent :
1. ✅ Les managers sont fonctionnels
2. ➡️ Création de l'interface graphique (MainWindow.ui)
3. ➡️ Intégration UI avec les managers
4. ➡️ Application complète

---

## Aide Supplémentaire

Si rien ne fonctionne, envoie-moi :
```bash
# Résultat de ces commandes :
cmake --version
g++ --version
dir C:\Qt
```

Et je t'aiderai à diagnostiquer le problème !
