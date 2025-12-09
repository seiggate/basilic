# Guide de Configuration - Basilic Draft

Ce guide explique comment configurer et utiliser le système de draft avec les cartes Magic: The Gathering.

## Étape 1: Importer les Cartes

### Commande rapide
```bash
cd scripts
python import_to_supabase.py
```

Ce script va :
- Importer les sets (khm, woe, otj, lci, mkm, blb, dsk)
- Télécharger toutes les cartes depuis Scryfall
- Les stocker dans Supabase

**Temps estimé**: 2-5 minutes selon votre connexion

### Vérifier l'import

```bash
python -c "
import sys
sys.path.insert(0, '../client_py')
from core.supabase_client import get_supabase_client

supabase = get_supabase_client()
sets = supabase.table('sets').select('code, name, card_count').execute()

print('Sets disponibles:')
for s in sets.data:
    print(f'  - {s[\"code\"].upper()}: {s[\"name\"]} ({s[\"card_count\"]} cartes)')
"
```

## Étape 2: Tester le Système

### Exécuter l'exemple

```bash
cd scripts
python example_draft.py
```

Cet exemple montre :
1. Création d'un lobby
2. Ajout de joueurs
3. Changement de set
4. Démarrage du draft
5. Génération des boosters

## Étape 3: Utiliser dans Votre Code

### Créer un Lobby

```python
from core.lobby_manager import LobbyManager

manager = LobbyManager()

# Créer un lobby avec un set spécifique
lobby = manager.create_lobby(
    name="Mon Draft",
    creator_name="Votre Nom",
    max_players=8,
    set_code="khm"  # Kaldheim
)

print(f"Code du lobby: {lobby['code']}")
```

### Rejoindre un Lobby

```python
# Rejoindre avec le code
manager.join_lobby_by_code("ABC12", "Nom du Joueur")
```

### Changer le Set (avant le début)

```python
# Le créateur peut changer le set
manager.update_lobby_set(lobby['id'], "woe")  # Changer pour Wilds of Eldraine
```

### Lister les Sets Disponibles

```python
sets = manager.get_available_sets()
for s in sets:
    print(f"{s['code']}: {s['name']}")
```

### Démarrer le Draft

```python
draft = manager.start_draft(lobby['id'])

# draft contient:
# - draft['lobby']: info du lobby
# - draft['players']: liste des joueurs
# - draft['boosters']: dict { seat_position: [booster1, booster2, booster3] }

# Accéder au premier booster du joueur en position 0
first_booster = draft['boosters'][0][0]
for card in first_booster:
    print(f"{card['name']} - {card['rarity']}")
```

## Sets Disponibles par Défaut

| Code | Nom Complet |
|------|-------------|
| khm  | Kaldheim |
| woe  | Wilds of Eldraine |
| otj  | Outlaws of Thunder Junction |
| lci  | The Lost Caverns of Ixalan |
| mkm  | Murders at Karlov Manor |
| blb  | Bloomburrow |
| dsk  | Duskmourn: House of Horror |

## Ajouter Plus de Sets

Modifiez `scripts/import_to_supabase.py` ligne 12 :

```python
DEFAULT_SETS = ["khm", "woe", "otj", "lci", "mkm", "blb", "dsk", "nouveau_set"]
```

Puis relancez l'import.

## Structure d'un Booster

Chaque booster contient 14 cartes :
- 10 communes
- 3 uncommons
- 1 rare ou mythique (12.5% de chance d'avoir une mythique)

## API Complète

### LobbyManager

- `create_lobby(name, creator_name, max_players, set_code)` - Créer un lobby
- `join_lobby_by_code(code, player_name)` - Rejoindre avec code
- `update_lobby_set(lobby_id, set_code)` - Changer le set
- `get_lobby_players(lobby_id)` - Liste des joueurs
- `get_available_lobbies()` - Lobbies disponibles
- `get_available_sets()` - Sets disponibles
- `start_draft(lobby_id)` - Démarrer le draft
- `leave_lobby(lobby_id, player_name)` - Quitter

### BoosterGenerator

```python
from core.booster_generator import BoosterGenerator

generator = BoosterGenerator("khm")
booster = generator.generate_booster()  # Un booster
boosters = generator.generate_boosters(3)  # Trois boosters
```

## Dépannage

### Erreur: "No sets found"
- Vérifiez que l'import a été exécuté : `python scripts/import_to_supabase.py`
- Vérifiez votre `.env` avec les credentials Supabase

### Erreur: "Not enough commons/uncommons"
- Le set n'a pas assez de cartes importées
- Relancez l'import pour ce set

### Performances
- L'import peut prendre quelques minutes
- Les boosters sont générés rapidement une fois les cartes importées
- Utilisez le cache local si vous générez beaucoup de boosters

## Prochaines Étapes

1. Intégrer dans l'interface Qt
2. Ajouter le système de WebSocket pour le draft temps réel
3. Gérer la rotation des boosters entre joueurs
4. Sauvegarder les decks construits
