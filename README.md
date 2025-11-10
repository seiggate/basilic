# 🐍 Basilic
**Basilic** est une application open-source inspirée de *Cockatrice*, dédiée aux formats **Draft**, **Scellé** et **Cube** de Magic: The Gathering.

---

## ✨ Fonctionnalités prévues
- 📚 Base de données complète des cartes Magic (Scryfall)
- 🧩 Draft local et en ligne (Pick2 / Classic / Cube)
- 💼 Scellé (Set / Cube / Chaos)
- 🧠 Arbre de tournoi automatique
- 👀 Mode spectateur
- 💾 Sauvegarde et verrouillage des decks
- 🔐 Comptes utilisateurs et sessions locales

---

## 🧱 Architecture
| Composant | Langage | Description |
|------------|----------|-------------|
| **Client prototype** | Python + PySide6 | Draft local, UI de test |
| **Client final** | C++ + Qt6 | Application complète et performante |
| **Base de données** | SQLite | Stockage des cartes, comptes et cubes |
| **Serveur** | Node.js (Express + WebSocket) | Draft multijoueur, spectateurs |
| **Importation** | Python (Scryfall API) | Génération de la base locale |

---

## 🚀 Installation (prototype)
```bash
git clone https://github.com/<ton-nom-utilisateur>/basilic.git
cd basilic/client_py
pip install -r ../requirements.txt
python main.py
