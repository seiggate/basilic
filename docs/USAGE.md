# Guide d'utilisation - Basilic Draft System

## Vue d'ensemble

Basilic est un système de draft Magic: The Gathering complet avec :
- Gestion de lobbies multi-joueurs
- Système de draft avec rotation des boosters
- Support de plusieurs sets MTG
- Persistance complète dans Supabase

## Installation

1. Installer les dépendances Python :
```bash
pip install -r requirements.txt
```

2. Configurer Supabase (déjà fait si .env existe) :
```bash
# Les variables sont dans .env
VITE_SUPABASE_URL=...
VITE_SUPABASE_ANON_KEY=...
```

## Scripts disponibles

### 1. Import des cartes (à faire en premier)

```bash
python scripts/import_to_supabase.py
```

Importe toutes les cartes MTG depuis Scryfall vers Supabase (2-5 minutes).

### 2. Vérification de la base de données

```bash
python scripts/check_database.py
```

Affiche l'état actuel : sets, cartes, lobbies.

### 3. Exemple de workflow complet

```bash
python scripts/example_draft.py
```

Démontre :
- Création d'un lobby
- Ajout de joueurs
- Changement de set
- Démarrage du draft

### 4. Simulation d'un draft complet

```bash
python scripts/test_complete_draft.py
```

Simule un draft complet avec 4 joueurs IA qui font tous leurs picks automatiquement.

Montre :
- Les 3 rounds de draft
- Les 14 picks par round
- La rotation des boosters (gauche/droite)
- Le résumé final avec les pools

### 5. Draft interactif

```bash
python scripts/interactive_draft.py
```

Participez à un draft en mode ligne de commande !

- Vous contrôlez le joueur 0
- 3 IA contrôlent les autres joueurs
- Choisissez vos cartes à chaque pick
- Voyez votre pool se construire en temps réel

## Architecture du système

### Tables Supabase

1. **sets** - Sets MTG disponibles
   - code, name, release_date, total_cards

2. **cards** - Toutes les cartes MTG
   - id, name, set_code, rarity, type_line, image_uri, etc.

3. **lobbies** - Salles d'attente
   - id, code, name, max_players, set_code, status

4. **lobby_players** - Joueurs dans les lobbies
   - id, lobby_id, player_name, seat_position

5. **drafts** - Drafts en cours
   - id, lobby_id, current_round, current_pick, direction, status

6. **draft_packs** - Boosters en circulation
   - id, draft_id, player_seat, round_number, cards, current_owner_seat

7. **draft_picks** - Historique des picks
   - id, draft_id, player_seat, card_id, round_number, pick_number

8. **player_pools** - Pools de cartes des joueurs
   - id, draft_id, player_seat, cards

### Managers Python

1. **LobbyManager** (`client_py/core/lobby_manager.py`)
   - Création/gestion de lobbies
   - Ajout de joueurs
   - Changement de set
   - Démarrage du draft

2. **DraftManager** (`client_py/core/draft_manager.py`)
   - Initialisation du draft
   - Gestion des picks
   - Rotation des boosters
   - Détection de fin de round/draft

3. **BoosterGenerator** (`client_py/core/booster_generator.py`)
   - Génération de boosters réalistes
   - Distribution par rareté (10C, 3U, 1R/M)
   - Support de tous les sets

## Workflow du draft

### Phase 1 : Création du lobby

```python
from core.lobby_manager import LobbyManager

manager = LobbyManager()

# Créer un lobby
lobby = manager.create_lobby(
    name="Mon Draft",
    creator_name="Alice",
    max_players=8,
    set_code="khm"
)

# Autres joueurs rejoignent
manager.join_lobby_by_code(lobby['code'], "Bob")
manager.join_lobby_by_code(lobby['code'], "Charlie")
```

### Phase 2 : Configuration

```python
# Changer le set si nécessaire
manager.update_lobby_set(lobby['id'], "woe")

# Vérifier qui est dans le lobby
players = manager.get_lobby_players(lobby['id'])
```

### Phase 3 : Draft

```python
# Démarrer le draft (minimum 4 joueurs)
draft = manager.start_draft(lobby['id'])
draft_id = draft['draft_id']

# Initialiser le manager de draft
from core.draft_manager import DraftManager
draft_mgr = DraftManager(draft_id)
draft_mgr.player_count = len(players)

# Boucle de draft
while True:
    state = draft_mgr.get_draft_state()
    if state['status'] == 'completed':
        break

    # Chaque joueur fait son pick
    for seat in range(player_count):
        pack = draft_mgr.get_current_pack(seat)
        if pack:
            card_id = pack[0]['id']  # Ou logique de choix
            draft_mgr.make_pick(seat, card_id)

    # Passer les boosters
    if draft_mgr.check_all_picks_made():
        draft_mgr.pass_packs()
```

### Phase 4 : Résultats

```python
# Obtenir le pool d'un joueur
pool = draft_mgr.get_player_pool(seat)

# Obtenir le résumé complet
summary = draft_mgr.get_draft_summary()
```

## Prochaines étapes

### WebSocket pour temps réel (TODO)

Pour synchroniser plusieurs clients en temps réel :
- Utiliser le serveur Node.js (`server_node/index.js`)
- WebSocket avec Socket.io
- Events : `pick_made`, `pack_passed`, `round_complete`

### Interface graphique PyQt (TODO)

- Affichage visuel des cartes
- Sélection interactive
- Visualisation du pool
- Stats en temps réel

### Matchmaking automatique (TODO)

- File d'attente par set
- Appariement automatique à 8 joueurs
- Système de ranking

## Support

Pour toute question ou bug :
- Consulter `/docs/ARCHITECTURE.md`
- Consulter `/docs/DATABASE.md`
- Consulter `/docs/DRAFT_LOGIC.md`
