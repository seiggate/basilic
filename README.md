# 🐍 Basilic
**Basilic** est une application open-source inspirée de *Cockatrice*, dédiée aux formats **Draft**, **Scellé** et **Cube** de Magic: The Gathering.

---

## ✨ Fonctionnalités
- 📚 Base de données complète des cartes Magic (Scryfall)
- 🧩 Draft local avec simulation IA (8 joueurs)
- 🎲 Générateur de Play Booster avec support des raretés
- 🌐 Système de lobby en ligne avec Supabase
  - Création de lobbies avec code unique
  - Support de 4 à 8 joueurs
  - Choix de siège autour d'une table ronde
  - Noms personnalisés ou anonymes
- 💼 Scellé (Set / Cube / Chaos) - en développement
- 🧠 Arbre de tournoi automatique - en développement
- 👀 Mode spectateur - en développement

---

## 🧱 Architecture
| Composant | Langage | Description |
|------------|----------|-------------|
| **Client prototype** | Python + PySide6 | Draft local, UI de test |
| **Client final** | C++ + Qt6 | Application complète et performante |
| **Base de données** | SQLite + Supabase | Stockage local des cartes, lobbies en ligne |
| **Backend** | Supabase | Gestion des lobbies multijoueurs en temps réel |
| **Importation** | Python (Scryfall API) | Génération de la base locale |

---

## 🚀 Installation (prototype)
```bash
git clone https://github.com/<ton-nom-utilisateur>/basilic.git
cd basilic

# Configuration Supabase
cp .env.example .env
# Editer .env et ajouter vos clés Supabase

# Installation et lancement
pip install -r requirements.txt
cd client_py
python main.py
