# 🚀 Basilic - Quick Start Guide

## Démarrage rapide en 5 minutes

### 1. Vérifier la base de données

```bash
python scripts/check_database.py
```

Si vous avez déjà des sets et des cartes, passez à l'étape 2.

### 2. Importer les cartes (si nécessaire)

```bash
python scripts/import_to_supabase.py
```

⏱️ Durée : 2-5 minutes pour importer ~2000 cartes

### 3. Tester le système

#### Option A : Workflow de base
```bash
python scripts/example_draft.py
```

Montre comment :
- Créer un lobby
- Ajouter des joueurs
- Changer le set
- Démarrer un draft

#### Option B : Simulation complète
```bash
python scripts/test_complete_draft.py
```

Simule un draft complet avec 4 joueurs IA :
- 3 rounds
- 14 picks par round
- Rotation automatique des boosters
- Affiche les pools finaux

#### Option C : Mode interactif 🎮
```bash
python scripts/interactive_draft.py
```

Participez au draft vous-même :
- Choisissez vos cartes
- Les IA contrôlent les autres joueurs
- Voyez votre pool se construire

## 📚 Système implémenté

### ✅ Fonctionnalités disponibles

1. **Gestion de lobbies**
   - Création avec code unique
   - Ajout de joueurs (4-8)
   - Sélection du set
   - Validation du nombre de joueurs

2. **Système de draft complet**
   - Génération de boosters réalistes
   - 3 rounds de draft
   - Rotation gauche (R1, R3) / droite (R2)
   - Gestion des picks
   - Persistance dans Supabase

3. **Gestion des cartes**
   - Import depuis Scryfall
   - 7 sets disponibles
   - Distribution par rareté (C/U/R/M)
   - Métadonnées complètes

4. **Persistance**
   - Tous les états sauvegardés
   - Historique complet des picks
   - Pools de cartes par joueur
   - Support multi-draft simultané

### 🚧 À implémenter

1. **Synchronisation temps réel**
   - WebSocket pour clients multiples
   - Events de draft en direct
   - Notifications de picks

2. **Interface graphique**
   - PyQt6 pour le client desktop
   - Affichage visuel des cartes
   - Drag & drop pour les picks
   - Visualisation du pool

3. **Features avancées**
   - Matchmaking automatique
   - Système de ranking
   - Replay de draft
   - Statistiques détaillées

## 🏗️ Architecture

```
Basilic/
├── client_py/           # Client Python
│   ├── core/           # Logique métier
│   │   ├── lobby_manager.py    # Gestion lobbies
│   │   ├── draft_manager.py    # Gestion draft
│   │   ├── booster_generator.py # Génération boosters
│   │   └── supabase_client.py  # Client Supabase
│   └── ui/             # Interface PyQt
│
├── scripts/            # Scripts de test/admin
│   ├── check_database.py       # Vérifier DB
│   ├── import_to_supabase.py   # Import cartes
│   ├── example_draft.py        # Workflow basique
│   ├── test_complete_draft.py  # Simulation IA
│   └── interactive_draft.py    # Draft interactif
│
├── docs/              # Documentation
│   ├── USAGE.md       # Guide complet
│   └── ...
│
└── supabase/          # Migrations DB
    └── migrations/
```

## 📊 Base de données Supabase

### Tables principales

- **sets** : Sets MTG (DSK, BLB, KHM, etc.)
- **cards** : ~2000 cartes avec métadonnées
- **lobbies** : Salles d'attente pour drafts
- **lobby_players** : Joueurs dans les lobbies
- **drafts** : État des drafts en cours
- **draft_packs** : Boosters en circulation
- **draft_picks** : Historique des picks
- **player_pools** : Pools de cartes des joueurs

Toutes les tables ont :
- RLS (Row Level Security) activé
- Policies pour lecture/écriture
- Indexes pour performance
- Foreign keys pour intégrité

## 🎯 Exemples de code

### Créer et démarrer un draft

```python
from core.lobby_manager import LobbyManager

manager = LobbyManager()

# Créer lobby
lobby = manager.create_lobby("Mon Draft", "Alice", 8, "khm")

# Ajouter joueurs
manager.join_lobby_by_code(lobby['code'], "Bob")
manager.join_lobby_by_code(lobby['code'], "Charlie")
manager.join_lobby_by_code(lobby['code'], "Diana")

# Démarrer
draft = manager.start_draft(lobby['id'])
print(f"Draft ID: {draft['draft_id']}")
```

### Faire des picks

```python
from core.draft_manager import DraftManager

draft_mgr = DraftManager(draft_id)
draft_mgr.player_count = 4

# Voir mon booster
pack = draft_mgr.get_current_pack(player_seat=0)
for i, card in enumerate(pack):
    print(f"{i+1}. {card['name']} ({card['rarity']})")

# Faire un pick
draft_mgr.make_pick(player_seat=0, card_id=pack[0]['id'])

# Passer les boosters
if draft_mgr.check_all_picks_made():
    draft_mgr.pass_packs()
```

### Voir les résultats

```python
# Pool d'un joueur
pool = draft_mgr.get_player_pool(0)
print(f"Cards: {len(pool)}")

# Résumé complet
summary = draft_mgr.get_draft_summary()
print(f"Status: {summary['draft']['status']}")
print(f"Total picks: {summary['total_picks']}")
```

## 🔧 Configuration

Les variables d'environnement sont dans `.env` :

```env
VITE_SUPABASE_URL=https://xxx.supabase.co
VITE_SUPABASE_ANON_KEY=xxx
```

## 📖 Documentation complète

- `/docs/USAGE.md` - Guide d'utilisation détaillé
- `/docs/ARCHITECTURE.md` - Architecture du système
- `/docs/DATABASE.md` - Schéma de la base de données
- `/docs/DRAFT_LOGIC.md` - Logique du draft

## 🎉 Prêt à drafter !

Tout est en place pour :
1. Créer des lobbies
2. Ajouter des joueurs
3. Générer des boosters
4. Faire des drafts complets
5. Sauvegarder tout dans Supabase

Essayez `python scripts/interactive_draft.py` pour voir le système en action !
