# Systeme de Lobby

Le systeme de lobby permet aux joueurs de se retrouver pour jouer ensemble en ligne.

## Fonctionnalites

### Creation de Lobby
- Le createur peut nommer le lobby
- Choix du nombre de joueurs (4-8)
- Generation automatique d'un code unique (5 caracteres)
- Le createur peut entrer son nom (max 20 caracteres) ou rester anonyme

### Rejoindre un Lobby
- Liste des lobbies disponibles actualisee toutes les 3 secondes
- Affichage: nom du lobby, code, nombre de joueurs actuels/maximum
- Double-clic pour rejoindre
- Possibilite d'entrer un nom personnalise ou rester anonyme

### Table Ronde Visuelle
- Representation graphique d'une table ronde
- Sieges numerotes de 1 a N (selon le nombre de joueurs)
- Sieges occupes affiches en vert avec le nom du joueur
- Le createur (HOST) est identifie par une etiquette doree
- Attribution automatique des sieges disponibles

### Gestion du Lobby
- Le lobby se met a jour automatiquement toutes les 2 secondes
- Les joueurs peuvent quitter le lobby a tout moment
- Si tous les joueurs quittent, le lobby est automatiquement supprime
- Le createur peut lancer la partie uniquement quand le lobby est complet

## Architecture Technique

### Base de Donnees (Supabase)

#### Table `lobbies`
- `id`: UUID (cle primaire)
- `name`: Nom du lobby
- `code`: Code unique de 5 caracteres
- `creator_name`: Nom du createur
- `max_players`: Nombre maximum de joueurs (4-8)
- `status`: 'waiting', 'in_progress', 'completed'
- `created_at`: Date de creation
- `updated_at`: Date de mise a jour

#### Table `lobby_players`
- `id`: UUID (cle primaire)
- `lobby_id`: Reference vers le lobby
- `player_name`: Nom du joueur
- `seat_position`: Position a la table (0-7)
- `is_creator`: Booleen indiquant si c'est le createur
- `joined_at`: Date de connexion

### Securite (RLS)
- Tous les joueurs peuvent voir les lobbies en attente
- Tous les joueurs peuvent creer et rejoindre des lobbies
- Les politiques RLS empechent les acces non autorises

### Client (PySide6)
- Widget `RoundTableWidget` pour la visualisation de la table
- Rafraichissement automatique via QTimer
- Integration avec l'API Supabase pour les operations en temps reel

## Configuration

1. Copier `.env.example` vers `.env`
2. Ajouter vos identifiants Supabase:
   - `SUPABASE_URL`: URL de votre projet Supabase
   - `SUPABASE_ANON_KEY`: Cle anonyme de votre projet

## Utilisation

### Creer un lobby
1. Cliquer sur "Creer un Lobby"
2. Entrer votre nom (ou laisser "Anonymous")
3. Entrer le nom du lobby
4. Choisir le nombre de joueurs
5. Cliquer sur "Creer"

### Rejoindre un lobby
1. Voir la liste des lobbies disponibles
2. Double-cliquer sur un lobby
3. Entrer votre nom
4. Vous rejoignez automatiquement le premier siege disponible

### Lancer une partie
1. Attendre que tous les sieges soient occupes
2. Le createur voit apparaitre le bouton "Lancer la partie"
3. Cliquer pour demarrer
