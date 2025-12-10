# Basilic C++/Qt Client

Client natif C++/Qt pour le système de draft Magic: The Gathering.

---

## 📋 Prérequis

### Tous les systèmes
- **CMake** 3.16 ou supérieur
- **Qt6** (Core, Widgets, Network, Gui)
- **Compilateur C++17** compatible

### Installation Qt6

#### Windows
```bash
# Télécharger depuis https://www.qt.io/download
# Ou avec winget:
winget install -e --id Qt.Qt
```

#### macOS
```bash
brew install qt6
```

#### Linux (Ubuntu/Debian)
```bash
sudo apt update
sudo apt install qt6-base-dev qt6-tools-dev cmake build-essential
```

#### Linux (Fedora)
```bash
sudo dnf install qt6-qtbase-devel qt6-qttools-devel cmake gcc-c++
```

---

## 🔧 Configuration

1. Copier le fichier `.env.example` vers `.env` à la racine du projet
2. Renseigner vos credentials Supabase dans `.env` :
   ```
   SUPABASE_URL=https://votre-projet.supabase.co
   SUPABASE_ANON_KEY=votre-clé-anonyme
   ```

---

## 🚀 Compilation

### Linux/macOS
```bash
cd client_cpp
mkdir build
cd build
cmake ..
cmake --build .
```

### Windows (Visual Studio)
```bash
cd client_cpp
mkdir build
cd build
cmake .. -G "Visual Studio 17 2022"
cmake --build . --config Release
```

### Windows (MinGW)
```bash
cd client_cpp
mkdir build
cd build
cmake .. -G "MinGW Makefiles"
cmake --build .
```

---

## ▶️ Exécution

### Linux/macOS
```bash
cd build
./Basilic
```

### Windows
```bash
cd build\Release
Basilic.exe
```

---

## 📁 Structure du Projet

```
client_cpp/
├── main.cpp                  # Point d'entrée
├── CMakeLists.txt           # Configuration CMake
│
├── model/                   # Modèles de données
│   ├── Card.h/cpp
│   ├── Set.h/cpp
│   ├── Booster.h/cpp
│   ├── Lobby.h/cpp
│   └── Draft.h/cpp
│
├── manager/                 # Logique métier
│   ├── SupabaseClient.h/cpp
│   ├── DatabaseManager.h/cpp
│   ├── LobbyManager.h/cpp
│   └── DraftManager.h/cpp
│
├── ui/                      # Interface utilisateur
│   ├── MainWindow.h/cpp/ui
│   ├── RoundTableWidget.h/cpp
│   └── CardWidget.h/cpp
│
└── utils/                   # Utilitaires
    └── Config.h/cpp
```

---

## 🐛 Débogage

### CMake verbose
```bash
cmake --build . --verbose
```

### Vérifier Qt6
```bash
cmake .. -DCMAKE_PREFIX_PATH=/path/to/Qt/6.x.x/gcc_64
```

### Logs de l'application
Les logs Qt sont affichés dans la console avec `qDebug()`, `qWarning()`, etc.

---

## 📦 Déploiement

### Windows
```bash
windeployqt Basilic.exe
```

### macOS
```bash
macdeployqt Basilic.app
```

### Linux (AppImage)
```bash
linuxdeployqt Basilic -appimage
```

---

## 🔗 Différences avec le client Python

| Aspect | Python | C++/Qt |
|--------|--------|--------|
| Performance | Interprété | Compilé (plus rapide) |
| UI | PySide6 | Qt6 natif |
| Typage | Dynamique | Statique |
| Distribution | PyInstaller | Binaire natif |
| Mémoire | Garbage collector | Smart pointers Qt |

---

## 📚 Documentation Qt

- [Qt6 Documentation](https://doc.qt.io/qt-6/)
- [Qt Network](https://doc.qt.io/qt-6/qtnetwork-index.html)
- [Qt Widgets](https://doc.qt.io/qt-6/qtwidgets-index.html)

---

## 🤝 Contribution

Voir le fichier principal [README.md](../README.md) pour les guidelines de contribution.
