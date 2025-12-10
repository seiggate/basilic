# client_py/ui/main_window.py
import os
import sys
import random
import string
import socket
import json
from math import ceil
from pathlib import Path
from threading import Thread

import requests
from PySide6.QtCore import Qt, QTimer
from PySide6.QtGui import QPixmap, QPainter, QColor, QFont
from PySide6.QtWidgets import (
    QApplication,
    QMainWindow,
    QWidget,
    QHBoxLayout,
    QVBoxLayout,
    QLabel,
    QTableWidget,
    QTableWidgetItem,
    QHeaderView,
    QAbstractItemView,
    QPushButton,
    QListWidget,
    QTabWidget,
    QGridLayout,
    QScrollArea,
    QMessageBox,
    QDialog,
    QLineEdit,
    QInputDialog,
    QSpinBox,
    QFormLayout,
)

from core.supabase_client import get_supabase_client


class RoundTableWidget(QWidget):
    """Widget showing a round table with player seats"""
    def __init__(self):
        super().__init__()
        self.players = []
        self.max_players = 8
        self.setMinimumSize(500, 500)
        self.setStyleSheet("background: white; border: 1px solid #ddd; border-radius: 8px;")

    def set_players(self, players, max_players):
        self.players = players
        self.max_players = max_players
        self.update()

    def paintEvent(self, event):
        painter = QPainter(self)
        painter.setRenderHint(QPainter.Antialiasing)

        width = self.width()
        height = self.height()
        center_x = width // 2
        center_y = height // 2

        table_radius = min(width, height) // 3
        painter.setBrush(QColor("#8B4513"))
        painter.setPen(QColor("#654321"))
        painter.drawEllipse(center_x - table_radius, center_y - table_radius, table_radius * 2, table_radius * 2)

        seat_radius = min(width, height) // 2 - 60
        occupied_seats = {p['seat_position']: p for p in self.players}

        import math
        for i in range(self.max_players):
            angle = (i / self.max_players) * 2 * math.pi - math.pi / 2
            x = center_x + int(seat_radius * math.cos(angle))
            y = center_y + int(seat_radius * math.sin(angle))

            if i in occupied_seats:
                player = occupied_seats[i]
                painter.setBrush(QColor("#4CAF50"))
                painter.setPen(QColor("#2E7D32"))
                painter.drawEllipse(x - 30, y - 30, 60, 60)

                painter.setPen(QColor("white"))
                font = QFont("Arial", 10, QFont.Bold)
                painter.setFont(font)
                name = player['player_name'][:10]
                text_rect = painter.boundingRect(x - 30, y - 10, 60, 20, Qt.AlignCenter, name)
                painter.drawText(text_rect, Qt.AlignCenter, name)

                if player.get('is_creator'):
                    painter.setPen(QColor("#FFD700"))
                    painter.drawText(x - 30, y + 25, 60, 15, Qt.AlignCenter, "HOST")
            else:
                painter.setBrush(QColor("#E0E0E0"))
                painter.setPen(QColor("#BDBDBD"))
                painter.drawEllipse(x - 30, y - 30, 60, 60)

                painter.setPen(QColor("#757575"))
                font = QFont("Arial", 9)
                painter.setFont(font)
                painter.drawText(x - 30, y - 5, 60, 20, Qt.AlignCenter, f"Si\u00e8ge {i+1}")


# Détection de l'environnement PyInstaller
def get_app_data_dir():
    """Retourne le répertoire de données de l'application"""
    if getattr(sys, 'frozen', False):
        # Mode exécutable PyInstaller
        if os.name == 'nt':  # Windows
            base = Path(os.environ.get('APPDATA', Path.home() / 'AppData' / 'Roaming'))
        else:  # Linux/Mac
            base = Path.home() / '.local' / 'share'
        return base / 'Basilic'
    else:
        # Mode développement
        return Path(__file__).parent.parent

# Création des répertoires nécessaires
APP_DATA_DIR = get_app_data_dir()
APP_DATA_DIR.mkdir(parents=True, exist_ok=True)

# Chemins des fichiers
DB_PATH = APP_DATA_DIR / "basilic.db"
CACHE_DIR = APP_DATA_DIR / "cache_booster"
CACHE_DIR.mkdir(parents=True, exist_ok=True)


# Note: Base de données SQLite locale désactivée - on utilise Supabase maintenant


class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Basilic")
        self.resize(1200, 700)

        # onglets
        self.tabs = QTabWidget()
        self.setCentralWidget(self.tabs)

        # Initialize Supabase and state BEFORE setting up tabs
        self.draft_state = None
        self.lobby_state = None
        self.current_lobby_id = None
        self.current_player_id = None
        self.available_sets = []
        self.supabase = get_supabase_client()
        self.lobby_refresh_timer = QTimer()
        self.lobby_refresh_timer.timeout.connect(self.refresh_lobbies)
        self.lobby_refresh_timer.start(3000)

        self.cleanup_timer = QTimer()
        self.cleanup_timer.timeout.connect(self.cleanup_abandoned_lobbies)
        self.cleanup_timer.start(300000)

        # Load available sets from Supabase
        self.load_available_sets()

        # setup tabs AFTER Supabase initialization
        self._setup_library_tab()
        self._setup_booster_tab()
        self._setup_simulate_tab()
        self._setup_lobby_tab()

    # ---------------------- BIBLIOTHÈQUE ----------------------
    def _setup_library_tab(self):
        lib_widget = QWidget()
        main_layout = QHBoxLayout(lib_widget)

        # table des cartes
        self.table = QTableWidget()
        self.table.setColumnCount(5)
        self.table.setHorizontalHeaderLabels(["Nom", "Coût", "Type", "Rareté", "Set"])
        self.table.horizontalHeader().setSectionResizeMode(QHeaderView.Stretch)
        self.table.setSelectionBehavior(QAbstractItemView.SelectRows)
        self.table.setSelectionMode(QAbstractItemView.SingleSelection)
        self.table.cellClicked.connect(self.show_card_image)

        # zone d'image à droite
        self.image_label = QLabel("Cliquez sur une carte pour voir son illustration")
        self.image_label.setAlignment(Qt.AlignCenter)
        self.image_label.setFixedWidth(350)
        self.image_label.setStyleSheet("border:1px solid #888; background:#111; color:#ddd;")

        main_layout.addWidget(self.table, stretch=3)
        main_layout.addWidget(self.image_label, stretch=1)

        self.tabs.addTab(lib_widget, "Bibliothèque")
        self._load_cards()

    def _load_cards(self):
        """Charge les cartes depuis Supabase."""
        try:
            supabase = get_supabase_client()
            if not supabase:
                print("⚠️ Supabase non configuré, bibliothèque vide")
                return

            response = supabase.table("cards").select("name, mana_cost, type_line, rarity, set_code, image_uri, colors").order("name").execute()
            cards = response.data

            self.table.setRowCount(len(cards))
            self.card_images = []
            self.card_mana_costs = []
            self.card_color_ids = []

            for i, card in enumerate(cards):
                name = card.get("name", "")
                mana_cost = card.get("mana_cost", "")
                type_line = card.get("type_line", "")
                rarity = card.get("rarity", "")
                set_code = card.get("set_code", "")
                image_url = card.get("image_uri", "")
                colors = card.get("colors", [])

                self.table.setItem(i, 0, QTableWidgetItem(name))
                self.table.setItem(i, 1, QTableWidgetItem(mana_cost))
                self.table.setItem(i, 2, QTableWidgetItem(type_line))
                self.table.setItem(i, 3, QTableWidgetItem(rarity))
                self.table.setItem(i, 4, QTableWidgetItem(set_code))

                self.card_images.append(image_url)
                self.card_mana_costs.append(mana_cost)
                self.card_color_ids.append(','.join(colors) if colors else '')

            print(f"✅ {len(cards)} cartes chargées depuis Supabase")
        except Exception as e:
            print(f"❌ Erreur chargement cartes: {e}")
            QMessageBox.warning(self, "Erreur", f"Impossible de charger les cartes: {e}")

    def show_card_image(self, row, col):
        """Affiche l'image de la carte sélectionnée (clic)."""
        try:
            url = self.card_images[row]
        except IndexError:
            self.image_label.setText("Aucune image")
            return

        if not url:
            self.image_label.setText("Aucune image")
            self.image_label.setPixmap(QPixmap())
            return

        try:
            resp = requests.get(url, timeout=8)
            resp.raise_for_status()
            pix = QPixmap()
            pix.loadFromData(resp.content)
            self.image_label.setPixmap(
                pix.scaled(
                    self.image_label.width(),
                    self.image_label.height(),
                    Qt.KeepAspectRatio,
                    Qt.SmoothTransformation,
                )
            )
        except Exception as e:
            print("Erreur chargement image :", e)
            self.image_label.setText("Erreur chargement image")

    # ---------------------- BOOSTER ----------------------
    def _setup_booster_tab(self):
        booster_widget = QWidget()
        layout = QVBoxLayout(booster_widget)

        # bouton générer
        self.btn_generate = QPushButton("Générer un Play Booster")
        self.btn_generate.clicked.connect(self.generate_booster)

        # liste texte (reste utile)
        self.booster_list = QListWidget()
        self.booster_list.setStyleSheet("font-size: 15px;")

        # zone d'images (grid 3 par ligne)
        self.images_widget = QWidget()
        self.images_layout = QGridLayout(self.images_widget)
        self.images_layout.setSpacing(8)
        # paramètres d'affichage des miniatures
        self.thumb_width = 160
        self.thumb_height = 120
        self.images_widget.setStyleSheet("background: #f5f5f5;")

        layout.addWidget(self.btn_generate)
        layout.addWidget(self.booster_list)
        layout.addWidget(self.images_widget)

        self.tabs.addTab(booster_widget, "Booster")

    # utilitaires DB (robustes si colonnes manquantes)
    def fetch_cards(self, set_code=None):
        """Retourne tuples (name, rarity, mana_cost, colors) depuis Supabase"""
        try:
            supabase = get_supabase_client()
            if not supabase:
                return []

            query = supabase.table("cards").select("name, rarity, mana_cost, colors")
            if set_code:
                query = query.eq("set_code", set_code)

            response = query.execute()
            cards = response.data

            return [(c.get('name', ''), c.get('rarity', ''), c.get('mana_cost', ''),
                     ','.join(c.get('colors', []))) for c in cards]
        except Exception as e:
            print(f"❌ Erreur fetch_cards: {e}")
            return []

    # ---------- filtres monochromes basés sur mana_cost ----------
    def filter_monochrome_by_mana_cost(self, rows, color_letter):
        """
        rows: list of (name, rarity, mana_cost, color_identity)
        Renvoie uniquement les cartes common dont mana_cost contient color_letter
        et ne contient AUCUNE autre couleur (R,U,G,B,W) que color_letter.
        """
        results = []
        color_letters = ["R", "U", "G", "B", "W"]
        for name, rarity, mana_cost, ci in rows:
            if rarity != "common":
                continue
            if mana_cost is None:
                continue
            # must contain the desired color
            if color_letter not in mana_cost:
                continue
            # must NOT contain any other color symbol
            other_letters = [x for x in color_letters if x != color_letter]
            if any(x in mana_cost for x in other_letters):
                continue
            # passed checks
            results.append((name, rarity))
        return results

    def filter_mono_or_colorless_by_mana_cost(self, rows):
        """
        Retourne commons qui sont soit monochromes (mana_cost contains exactly one color)
        soit incolores (mana_cost empty or no color symbols).
        """
        results = []
        color_letters = ["R", "U", "G", "B", "W"]
        for name, rarity, mana_cost, ci in rows:
            if rarity != "common":
                continue
            # colorless
            if not mana_cost or not any(c in mana_cost for c in color_letters):
                results.append((name, rarity))
                continue
            # check if contains exactly one color and no others
            present = [c for c in color_letters if c in mana_cost]
            if len(present) == 1:
                results.append((name, rarity))
        return results

    @staticmethod
    def _pick_random(cards):
        return random.choice(cards) if cards else ("[Aucune carte]", "")

    # -------------------- génération du play booster --------------------
    def generate_booster(self):
        """Génère un Play Booster selon la spécification donnée."""
        # Récupère toutes les cartes depuis Supabase
        try:
            supabase = get_supabase_client()
            if not supabase:
                QMessageBox.warning(self, "Erreur", "Supabase non configuré")
                return

            # Récupère toutes les cartes avec set_code par défaut (blb)
            all_cards_response = supabase.table("cards").select("name, rarity, mana_cost, colors, type_line, set_code").eq("set_code", "blb").execute()
            all_cards = all_cards_response.data

            if not all_cards:
                QMessageBox.warning(self, "Erreur", "Aucune carte trouvée")
                return

            # Filtre par rareté
            commons_raw = [(c['name'], c['rarity'], c.get('mana_cost', ''), ','.join(c.get('colors', [])))
                          for c in all_cards if c['rarity'] == 'common']
            uncommons_raw = [(c['name'], c['rarity'], c.get('mana_cost', ''), ','.join(c.get('colors', [])))
                            for c in all_cards if c['rarity'] == 'uncommon']
            rares_raw = [(c['name'], c['rarity'], c.get('mana_cost', ''), ','.join(c.get('colors', [])))
                        for c in all_cards if c['rarity'] == 'rare']
            mythics_raw = [(c['name'], c['rarity'], c.get('mana_cost', ''), ','.join(c.get('colors', [])))
                          for c in all_cards if c['rarity'] == 'mythic']
            basics_raw = [(c['name'], c['rarity'], c.get('mana_cost', ''), ','.join(c.get('colors', [])))
                         for c in all_cards if 'Basic Land' in c.get('type_line', '')]

            # The List (pour l'instant vide, peut être ajouté plus tard)
            the_list_raw = []
        except Exception as e:
            QMessageBox.critical(self, "Erreur", f"Erreur lors du chargement des cartes: {e}")
            return

        # Pools (name, rarity) for easy picks when color not needed
        commons_simple = [(n, r) for (n, r, m, ci) in commons_raw]
        uncommons_simple = [(n, r) for (n, r, m, ci) in uncommons_raw]
        rares_simple = [(n, r) for (n, r, m, ci) in rares_raw]
        mythics_simple = [(n, r) for (n, r, m, ci) in mythics_raw]
        basics_simple = [(n, r) for (n, r, m, ci) in basics_raw]
        the_list_simple = [(n, r) for (n, r, m, ci) in the_list_raw]

        # monochrome pools from commons_raw using mana_cost heuristics
        commons_by_color = {
            "R": self.filter_monochrome_by_mana_cost(commons_raw, "R"),
            "U": self.filter_monochrome_by_mana_cost(commons_raw, "U"),
            "G": self.filter_monochrome_by_mana_cost(commons_raw, "G"),
            "B": self.filter_monochrome_by_mana_cost(commons_raw, "B"),
            "W": self.filter_monochrome_by_mana_cost(commons_raw, "W"),
        }

        # mono or colorless pool
        commons_mono_or_colorless = self.filter_mono_or_colorless_by_mana_cost(commons_raw)

        all_cards_simple = commons_simple + uncommons_simple + rares_simple + mythics_simple

        booster = []

        # 1) five strictly monochrome commons (R, U, G, B, W)
        for color in ["R", "U", "G", "B", "W"]:
            pool = commons_by_color.get(color, [])
            booster.append(self._pick_random(pool))

        # 2) one common mono or colorless
        booster.append(self._pick_random(commons_mono_or_colorless))

        # 3) one common (1.5% replaced by The List)
        if random.random() < 0.015 and the_list_simple:
            booster.append(self._pick_random(the_list_simple))
        else:
            booster.append(self._pick_random(commons_simple))

        # 4) three uncommons
        for _ in range(3):
            booster.append(self._pick_random(uncommons_simple))

        # 5) one random card from set (any rarity)
        booster.append(self._pick_random(all_cards_simple))

        # 6) rare (87.5%) or mythic (12.5%)
        if random.random() < 0.125:
            booster.append(self._pick_random(mythics_simple))
        else:
            booster.append(self._pick_random(rares_simple))

        # 7) one basic land
        booster.append(self._pick_random(basics_simple))

        # 8) one "foil" aesthetic card (random)
        booster.append(self._pick_random(all_cards_simple))

        # affichage texte (réinitialise la liste)
        self.booster_list.clear()
        for name, rarity in booster:
            self.booster_list.addItem(f"{name}   [{rarity}]")

        # --- préparation des miniatures : 3 par ligne, pas de scroll ---
        # recherche des URLs pour chaque carte sélectionnée
        booster_with_urls = []
        for name, rarity in booster:
            url = self._get_image_url_for_name(name)
            booster_with_urls.append((name, rarity, url))

        # nettoie l'ancienne grille
        while self.images_layout.count():
            item = self.images_layout.takeAt(0)
            widget = item.widget()
            if widget:
                widget.deleteLater()

        # ajouter les miniatures 3 par ligne
        cols = 3
        total = len(booster_with_urls)
        rows = ceil(total / cols)
        # fixe la hauteur du widget pour éviter le scroll : hauteur = rows * (thumb_height + spacing) + marge
        spacing = self.images_layout.spacing()
        widget_height = rows * (self.thumb_height + spacing) + 20
        self.images_widget.setFixedHeight(widget_height)

        for idx, (name, rarity, url) in enumerate(booster_with_urls):
            r = idx // cols
            c = idx % cols

            thumb = QLabel()
            thumb.setFixedSize(self.thumb_width, self.thumb_height)
            thumb.setAlignment(Qt.AlignCenter)
            thumb.setStyleSheet("border: 1px solid #999; background: #fff;")

            if url:
                pix = self._get_cached_pixmap(url)
                if pix:
                    scaled = pix.scaled(self.thumb_width, self.thumb_height, Qt.KeepAspectRatio, Qt.SmoothTransformation)
                    thumb.setPixmap(scaled)
                else:
                    thumb.setText("Impossible\nà charger")
            else:
                thumb.setText("Pas d'image")

            # petit label sous l'image si tu veux le nom (optionnel)
            label = QLabel(f"{name}\n[{rarity}]")
            label.setAlignment(Qt.AlignCenter)
            label.setFixedWidth(self.thumb_width)

            # wrapper vertical (image + label)
            vbox = QWidget()
            vlayout = QVBoxLayout(vbox)
            vlayout.setContentsMargins(2, 2, 2, 2)
            vlayout.setSpacing(4)
            vlayout.addWidget(thumb)
            vlayout.addWidget(label)
            self.images_layout.addWidget(vbox, r, c)

    # ---------- utilitaires image / cache ----------
    def _cache_filename(self, url: str) -> Path:
        """Retourne un chemin de cache pour une URL donnée."""
        import hashlib

        h = hashlib.md5(url.encode("utf-8")).hexdigest()
        ext = ".jpg"
        # try keep extension if present in url
        if "." in url.split("/")[-1]:
            possible_ext = "." + url.split("/")[-1].split(".")[-1].split("?")[0]
            if len(possible_ext) <= 5:
                ext = possible_ext
        return CACHE_DIR / f"{h}{ext}"

    def _get_cached_pixmap(self, url: str) -> QPixmap | None:
        """Retourne un QPixmap depuis le cache, ou télécharge et met en cache."""
        cache_path = self._cache_filename(url)
        try:
            if cache_path.exists():
                pix = QPixmap(str(cache_path))
                if not pix.isNull():
                    return pix
            # téléchargement
            resp = requests.get(url, timeout=8)
            resp.raise_for_status()
            with open(cache_path, "wb") as f:
                f.write(resp.content)
            pix = QPixmap(str(cache_path))
            if not pix.isNull():
                return pix
        except Exception as e:
            print("Erreur image/cache :", e)
        return None

    def _get_image_url_for_name(self, name: str) -> str | None:
        """Récupère une image_url pour une carte (premier résultat par nom)."""
        if not name:
            return None
        try:
            supabase = get_supabase_client()
            if not supabase:
                return None

            response = supabase.table("cards").select("image_uri").eq("name", name).limit(1).execute()
            if response.data and len(response.data) > 0:
                return response.data[0].get('image_uri')
        except Exception as e:
            print(f"❌ Erreur _get_image_url_for_name: {e}")
        return None

    # ---------------------- SIMULATION ----------------------
    def _setup_simulate_tab(self):
        simulate_widget = QWidget()
        main_layout = QHBoxLayout(simulate_widget)

        left_panel = QWidget()
        left_layout = QVBoxLayout(left_panel)

        self.btn_start_draft = QPushButton("Démarrer un Draft (8 joueurs)")
        self.btn_start_draft.clicked.connect(self.start_draft)

        self.draft_info_label = QLabel("Aucun draft en cours")
        self.draft_info_label.setStyleSheet("font-size: 14px; font-weight: bold; padding: 10px;")

        self.current_pack_area = QScrollArea()
        self.current_pack_area.setWidgetResizable(True)
        self.current_pack_widget = QWidget()
        self.current_pack_layout = QGridLayout(self.current_pack_widget)
        self.current_pack_layout.setSpacing(8)
        self.current_pack_area.setWidget(self.current_pack_widget)

        left_layout.addWidget(self.btn_start_draft)
        left_layout.addWidget(self.draft_info_label)
        left_layout.addWidget(QLabel("Booster actuel:"))
        left_layout.addWidget(self.current_pack_area)

        right_panel = QWidget()
        right_layout = QVBoxLayout(right_panel)

        right_layout.addWidget(QLabel("Vos picks:"))
        self.picked_cards_list = QListWidget()
        self.picked_cards_list.setStyleSheet("font-size: 13px;")
        right_layout.addWidget(self.picked_cards_list)

        main_layout.addWidget(left_panel, stretch=2)
        main_layout.addWidget(right_panel, stretch=1)

        self.tabs.addTab(simulate_widget, "Simulation")

    def start_draft(self):
        self.picked_cards_list.clear()

        self.draft_state = {
            'round': 1,
            'pick': 1,
            'packs': [],
            'picked_cards': [],
            'ai_picks': [[] for _ in range(7)]
        }

        for player_idx in range(8):
            pack = self._generate_draft_pack()
            self.draft_state['packs'].append(pack)

        self.btn_start_draft.setEnabled(False)
        self.update_draft_display()

    def _generate_draft_pack(self):
        """Génère un booster de draft depuis Supabase"""
        try:
            supabase = get_supabase_client()
            if not supabase:
                return []

            # Récupère toutes les cartes (set par défaut: blb)
            all_cards = supabase.table("cards").select("name, rarity, mana_cost, colors").eq("set_code", "blb").execute()

            if not all_cards.data:
                return []

            # Filtre par rareté
            commons_simple = [(c['name'], c['rarity']) for c in all_cards.data if c['rarity'] == 'common']
            uncommons_simple = [(c['name'], c['rarity']) for c in all_cards.data if c['rarity'] == 'uncommon']
            rares_simple = [(c['name'], c['rarity']) for c in all_cards.data if c['rarity'] == 'rare']
            mythics_simple = [(c['name'], c['rarity']) for c in all_cards.data if c['rarity'] == 'mythic']

            pack = []

            for _ in range(10):
                pack.append(self._pick_random(commons_simple))

            for _ in range(3):
                pack.append(self._pick_random(uncommons_simple))

            if random.random() < 0.125:
                pack.append(self._pick_random(mythics_simple))
            else:
                pack.append(self._pick_random(rares_simple))

            random.shuffle(pack)
            return pack
        except Exception as e:
            print(f"❌ Erreur _generate_draft_pack: {e}")
            return []

    def _generate_draft_pack_for_set(self, set_code):
        if not self.supabase:
            return []

        try:
            commons = self.supabase.table('cards').select('id, name, rarity').eq('set_code', set_code).eq('rarity', 'common').execute()
            uncommons = self.supabase.table('cards').select('id, name, rarity').eq('set_code', set_code).eq('rarity', 'uncommon').execute()
            rares = self.supabase.table('cards').select('id, name, rarity').eq('set_code', set_code).eq('rarity', 'rare').execute()
            mythics = self.supabase.table('cards').select('id, name, rarity').eq('set_code', set_code).eq('rarity', 'mythic').execute()

            pack_card_ids = []

            for _ in range(10):
                if commons.data:
                    card = random.choice(commons.data)
                    pack_card_ids.append(card['id'])

            for _ in range(3):
                if uncommons.data:
                    card = random.choice(uncommons.data)
                    pack_card_ids.append(card['id'])

            if random.random() < 0.125 and mythics.data:
                card = random.choice(mythics.data)
                pack_card_ids.append(card['id'])
            elif rares.data:
                card = random.choice(rares.data)
                pack_card_ids.append(card['id'])

            random.shuffle(pack_card_ids)
            return pack_card_ids

        except Exception as e:
            print(f"Erreur génération booster: {e}")
            return []

    def update_draft_display(self):
        if not self.draft_state:
            return

        round_num = self.draft_state['round']
        pick_num = self.draft_state['pick']
        total_picks = len(self.draft_state['picked_cards'])

        self.draft_info_label.setText(
            f"Ronde {round_num} - Pick {pick_num} (Total picks: {total_picks})"
        )

        while self.current_pack_layout.count():
            item = self.current_pack_layout.takeAt(0)
            widget = item.widget()
            if widget:
                widget.deleteLater()

        current_pack = self.draft_state['packs'][0]
        if not current_pack:
            self.advance_to_next_pack()
            return

        cols = 4
        for idx, (name, rarity) in enumerate(current_pack):
            r = idx // cols
            c = idx % cols

            card_block = self._create_card_block(name, rarity)
            self.current_pack_layout.addWidget(card_block, r, c)

    def _create_card_block(self, name, rarity):
        block = QWidget()
        block.setFixedSize(160, 280)
        block.setStyleSheet("""
            QWidget {
                background: white;
                border: 2px solid #ddd;
                border-radius: 8px;
            }
        """)

        layout = QVBoxLayout(block)
        layout.setContentsMargins(10, 10, 10, 10)
        layout.setSpacing(8)

        name_label = QLabel(name)
        name_label.setAlignment(Qt.AlignCenter)
        name_label.setWordWrap(True)
        name_label.setStyleSheet("""
            font-weight: bold;
            font-size: 12px;
            color: #333;
        """)
        name_label.setFixedHeight(30)

        image_label = QLabel()
        image_label.setFixedSize(140, 100)
        image_label.setAlignment(Qt.AlignCenter)
        image_label.setStyleSheet("background: #f5f5f5; border: 1px solid #ccc; border-radius: 4px;")

        url = self._get_image_url_for_name(name)
        if url:
            pix = self._get_cached_pixmap(url)
            if pix:
                scaled = pix.scaled(140, 100, Qt.KeepAspectRatio, Qt.SmoothTransformation)
                image_label.setPixmap(scaled)

        button_container = QWidget()
        button_layout = QHBoxLayout(button_container)
        button_layout.setContentsMargins(0, 0, 0, 0)
        button_layout.setSpacing(4)

        pick_btn = QPushButton("Choisir")
        pick_btn.setStyleSheet("""
            QPushButton {
                background: #4CAF50;
                color: white;
                border: none;
                border-radius: 4px;
                font-weight: bold;
                font-size: 11px;
                padding: 4px;
            }
            QPushButton:hover {
                background: #45a049;
            }
        """)
        pick_btn.clicked.connect(lambda: self.pick_card((name, rarity)))

        view_btn = QPushButton("Voir")
        view_btn.setStyleSheet("""
            QPushButton {
                background: #2196F3;
                color: white;
                border: none;
                border-radius: 4px;
                font-weight: bold;
                font-size: 11px;
                padding: 4px;
            }
            QPushButton:hover {
                background: #0b7dda;
            }
        """)
        view_btn.clicked.connect(lambda: self._show_card_detail(name, rarity))

        button_layout.addWidget(pick_btn)
        button_layout.addWidget(view_btn)

        layout.addWidget(name_label)
        layout.addWidget(image_label)
        layout.addWidget(button_container)
        layout.addStretch()

        return block

    def _show_card_detail(self, name, rarity):
        dialog = QDialog(self)
        dialog.setWindowTitle(name)
        dialog.setFixedSize(400, 600)

        layout = QVBoxLayout(dialog)

        title = QLabel(name)
        title.setAlignment(Qt.AlignCenter)
        title.setStyleSheet("font-weight: bold; font-size: 16px; color: #333;")

        image_label = QLabel()
        image_label.setAlignment(Qt.AlignCenter)
        image_label.setStyleSheet("background: #f5f5f5; border: 1px solid #ccc; border-radius: 4px;")

        url = self._get_image_url_for_name(name)
        if url:
            pix = self._get_cached_pixmap(url)
            if pix:
                scaled = pix.scaled(350, 500, Qt.KeepAspectRatio, Qt.SmoothTransformation)
                image_label.setPixmap(scaled)

        rarity_label = QLabel(f"Rareté: {rarity}")
        rarity_label.setAlignment(Qt.AlignCenter)
        rarity_label.setStyleSheet("font-size: 12px; color: #666;")

        close_btn = QPushButton("Fermer")
        close_btn.clicked.connect(dialog.accept)
        close_btn.setStyleSheet("""
            QPushButton {
                background: #f44336;
                color: white;
                border: none;
                border-radius: 4px;
                font-weight: bold;
                padding: 8px;
            }
            QPushButton:hover {
                background: #da190b;
            }
        """)

        layout.addWidget(title)
        layout.addWidget(image_label)
        layout.addWidget(rarity_label)
        layout.addStretch()
        layout.addWidget(close_btn)

        dialog.exec()

    def pick_card(self, card):
        if not self.draft_state:
            return

        name, rarity = card
        self.draft_state['picked_cards'].append(card)

        self.picked_cards_list.addItem(f"{name} [{rarity}]")

        current_pack = self.draft_state['packs'][0]
        current_pack.remove(card)

        self.ai_make_picks()

        self.draft_state['pick'] += 1

        if self.draft_state['round'] % 2 == 1:
            self.draft_state['packs'] = self.draft_state['packs'][1:] + [self.draft_state['packs'][0]]
        else:
            self.draft_state['packs'] = [self.draft_state['packs'][-1]] + self.draft_state['packs'][:-1]

        self.update_draft_display()

    def ai_make_picks(self):
        for i in range(1, 8):
            pack = self.draft_state['packs'][i]
            if pack:
                picked = random.choice(pack)
                self.draft_state['ai_picks'][i-1].append(picked)
                pack.remove(picked)

    def advance_to_next_pack(self):
        if self.draft_state['round'] >= 3:
            QMessageBox.information(self, "Draft terminé",
                                    f"Le draft est terminé!\n\nVous avez pick {len(self.draft_state['picked_cards'])} cartes.")
            self.btn_start_draft.setEnabled(True)
            self.draft_state = None
            self.draft_info_label.setText("Draft terminé")
            return

        self.draft_state['round'] += 1
        self.draft_state['pick'] = 1

        for player_idx in range(8):
            pack = self._generate_draft_pack()
            self.draft_state['packs'][player_idx] = pack

        self.update_draft_display()

    # ---------------------- LOBBY ----------------------
    def load_available_sets(self):
        if not self.supabase:
            return

        try:
            result = self.supabase.table('sets').select('code, name').order('name').execute()
            self.available_sets = result.data
        except Exception as e:
            print(f"Erreur chargement sets: {e}")
            self.available_sets = []

    def _setup_lobby_tab(self):
        lobby_widget = QWidget()
        main_layout = QVBoxLayout(lobby_widget)
        main_layout.setSpacing(15)
        main_layout.setContentsMargins(20, 20, 20, 20)

        title = QLabel("Lobbies de Draft")
        title.setStyleSheet("font-size: 20px; font-weight: bold; color: #333;")
        main_layout.addWidget(title)

        button_layout = QHBoxLayout()
        button_layout.setSpacing(10)

        create_btn = QPushButton("Créer un Lobby")
        create_btn.setFixedSize(180, 45)
        create_btn.setStyleSheet("""
            QPushButton {
                background: #4CAF50;
                color: white;
                border: none;
                border-radius: 6px;
                font-weight: bold;
                font-size: 13px;
            }
            QPushButton:hover {
                background: #45a049;
            }
        """)
        create_btn.clicked.connect(self.show_create_lobby_dialog)

        refresh_btn = QPushButton("Rafraîchir")
        refresh_btn.setFixedSize(120, 45)
        refresh_btn.setStyleSheet("""
            QPushButton {
                background: #2196F3;
                color: white;
                border: none;
                border-radius: 6px;
                font-weight: bold;
                font-size: 13px;
            }
            QPushButton:hover {
                background: #0b7dda;
            }
        """)
        refresh_btn.clicked.connect(self.refresh_lobbies)

        button_layout.addWidget(create_btn)
        button_layout.addWidget(refresh_btn)
        button_layout.addStretch()

        main_layout.addLayout(button_layout)

        self.lobby_list_widget = QListWidget()
        self.lobby_list_widget.setStyleSheet("""
            QListWidget {
                background: white;
                border: 1px solid #ddd;
                border-radius: 6px;
                font-size: 13px;
            }
            QListWidget::item {
                padding: 8px;
                border-bottom: 1px solid #eee;
            }
            QListWidget::item:hover {
                background: #f0f0f0;
            }
            QListWidget::item:selected {
                background: #e3f2fd;
                color: #333;
            }
        """)
        self.lobby_list_widget.itemDoubleClicked.connect(self.join_selected_lobby)
        main_layout.addWidget(self.lobby_list_widget)

        self.lobby_detail_widget = QWidget()
        self.lobby_detail_layout = QVBoxLayout(self.lobby_detail_widget)
        self.lobby_detail_layout.setContentsMargins(0, 10, 0, 0)

        self.round_table_widget = RoundTableWidget()
        self.lobby_detail_layout.addWidget(self.round_table_widget)

        self.btn_leave_lobby = QPushButton("Quitter le lobby")
        self.btn_leave_lobby.setStyleSheet("""
            QPushButton {
                background: #f44336;
                color: white;
                border: none;
                border-radius: 6px;
                font-weight: bold;
                padding: 10px;
            }
            QPushButton:hover {
                background: #da190b;
            }
        """)
        self.btn_leave_lobby.clicked.connect(self.leave_lobby)
        self.btn_leave_lobby.hide()

        self.btn_start_game = QPushButton("Lancer la partie")
        self.btn_start_game.setStyleSheet("""
            QPushButton {
                background: #FF9800;
                color: white;
                border: none;
                border-radius: 6px;
                font-weight: bold;
                padding: 12px;
                font-size: 14px;
            }
            QPushButton:hover {
                background: #F57C00;
            }
        """)
        self.btn_start_game.clicked.connect(self.start_game)
        self.btn_start_game.hide()

        self.lobby_detail_layout.addWidget(self.btn_leave_lobby)
        self.lobby_detail_layout.addWidget(self.btn_start_game)
        self.lobby_detail_widget.hide()

        main_layout.addWidget(self.lobby_detail_widget)

        self.tabs.addTab(lobby_widget, "Lobby")
        self.refresh_lobbies()

    def show_create_lobby_dialog(self):
        if not self.supabase:
            QMessageBox.warning(self, "Erreur", "Supabase non configuré")
            return

        dialog = QDialog(self)
        dialog.setWindowTitle("Créer un lobby")
        dialog.setFixedSize(400, 350)

        layout = QFormLayout(dialog)

        player_name_input = QLineEdit()
        player_name_input.setPlaceholderText("Votre nom (max 20 caractères)")
        player_name_input.setMaxLength(20)
        player_name_input.setText("Anonymous")

        lobby_name_input = QLineEdit()
        lobby_name_input.setPlaceholderText("Nom du lobby")
        lobby_name_input.setMaxLength(30)

        max_players_spin = QSpinBox()
        max_players_spin.setMinimum(4)
        max_players_spin.setMaximum(8)
        max_players_spin.setValue(8)

        from PySide6.QtWidgets import QComboBox
        set_combo = QComboBox()
        for set_info in self.available_sets:
            set_combo.addItem(f"{set_info['name']} ({set_info['code'].upper()})", set_info['code'])
        if set_combo.count() == 0:
            set_combo.addItem("Bloomburrow (BLB)", "blb")

        layout.addRow("Votre nom:", player_name_input)
        layout.addRow("Nom du lobby:", lobby_name_input)
        layout.addRow("Extension:", set_combo)
        layout.addRow("Nombre de joueurs:", max_players_spin)

        button_box = QHBoxLayout()
        create_btn = QPushButton("Créer")
        cancel_btn = QPushButton("Annuler")

        create_btn.setStyleSheet("""
            QPushButton {
                background: #4CAF50;
                color: white;
                border: none;
                border-radius: 4px;
                padding: 8px 20px;
                font-weight: bold;
            }
            QPushButton:hover {
                background: #45a049;
            }
        """)
        cancel_btn.clicked.connect(dialog.reject)

        def create():
            player_name = player_name_input.text().strip() or "Anonymous"
            lobby_name = lobby_name_input.text().strip() or "Partie de Draft"
            max_players = max_players_spin.value()
            set_code = set_combo.currentData() or "blb"
            self.create_lobby(player_name, lobby_name, max_players, set_code)
            dialog.accept()

        create_btn.clicked.connect(create)
        button_box.addWidget(cancel_btn)
        button_box.addWidget(create_btn)
        layout.addRow(button_box)

        dialog.exec()

    def create_lobby(self, player_name, lobby_name, max_players, set_code='blb'):
        if not self.supabase:
            return

        try:
            code = ''.join(random.choices(string.ascii_uppercase + string.digits, k=5))

            lobby_data = {
                'name': lobby_name,
                'code': code,
                'creator_name': player_name,
                'max_players': max_players,
                'status': 'waiting',
                'set_code': set_code
            }
            result = self.supabase.table('lobbies').insert(lobby_data).execute()
            lobby = result.data[0]

            player_data = {
                'lobby_id': lobby['id'],
                'player_name': player_name,
                'seat_position': 0,
                'is_creator': True
            }
            player_result = self.supabase.table('lobby_players').insert(player_data).execute()

            self.current_lobby_id = lobby['id']
            self.current_player_id = player_result.data[0]['id']

            QMessageBox.information(self, "Lobby créé", f"Lobby créé avec le code: {code}")
            self.refresh_lobbies()
            self.show_lobby_detail(lobby['id'])

        except Exception as e:
            QMessageBox.critical(self, "Erreur", f"Erreur lors de la création: {str(e)}")

    def refresh_lobbies(self):
        if not self.supabase:
            return

        try:
            result = self.supabase.table('lobbies').select('*, lobby_players(count)').eq('status', 'waiting').execute()
            lobbies = result.data

            self.lobby_list_widget.clear()
            for lobby in lobbies:
                player_count = len(lobby.get('lobby_players', []))
                item_text = f"{lobby['name']} | Code: {lobby['code']} | Joueurs: {player_count}/{lobby['max_players']}"
                self.lobby_list_widget.addItem(item_text)
                item = self.lobby_list_widget.item(self.lobby_list_widget.count() - 1)
                item.setData(Qt.UserRole, lobby['id'])

        except Exception as e:
            print(f"Erreur rafraîchissement: {e}")

    def join_selected_lobby(self, item):
        if self.current_lobby_id:
            QMessageBox.warning(self, "Attention", "Vous êtes déjà dans un lobby")
            return

        lobby_id = item.data(Qt.UserRole)

        player_name, ok = QInputDialog.getText(self, "Votre nom", "Entrez votre nom (max 20 caractères):")
        if not ok:
            return

        player_name = player_name.strip()[:20] or "Anonymous"

        self.join_lobby(lobby_id, player_name)

    def join_lobby(self, lobby_id, player_name):
        if not self.supabase:
            return

        try:
            lobby_result = self.supabase.table('lobbies').select('*, lobby_players(*)').eq('id', lobby_id).single().execute()
            lobby = lobby_result.data

            current_players = lobby.get('lobby_players', [])
            if len(current_players) >= lobby['max_players']:
                QMessageBox.warning(self, "Lobby plein", "Ce lobby est complet")
                return

            occupied_seats = [p['seat_position'] for p in current_players]
            available_seat = next(i for i in range(lobby['max_players']) if i not in occupied_seats)

            player_data = {
                'lobby_id': lobby_id,
                'player_name': player_name,
                'seat_position': available_seat,
                'is_creator': False
            }
            player_result = self.supabase.table('lobby_players').insert(player_data).execute()

            self.current_lobby_id = lobby_id
            self.current_player_id = player_result.data[0]['id']

            self.show_lobby_detail(lobby_id)

        except Exception as e:
            QMessageBox.critical(self, "Erreur", f"Erreur lors de la connexion: {str(e)}")

    def show_lobby_detail(self, lobby_id):
        self.lobby_detail_widget.show()
        self.btn_leave_lobby.show()
        self.update_lobby_detail()

        if not hasattr(self, 'lobby_detail_timer'):
            self.lobby_detail_timer = QTimer()
            self.lobby_detail_timer.timeout.connect(self.update_lobby_detail)
            self.lobby_detail_timer.start(2000)

    def update_lobby_detail(self):
        if not self.current_lobby_id or not self.supabase:
            return

        try:
            result = self.supabase.table('lobbies').select('*, lobby_players(*)').eq('id', self.current_lobby_id).single().execute()
            lobby = result.data

            players = lobby.get('lobby_players', [])
            self.round_table_widget.set_players(players, lobby['max_players'])

            is_creator = any(p['id'] == self.current_player_id and p['is_creator'] for p in players)
            if is_creator and len(players) == lobby['max_players']:
                self.btn_start_game.show()
            else:
                self.btn_start_game.hide()

        except Exception as e:
            print(f"Erreur mise à jour lobby: {e}")

    def leave_lobby(self):
        if not self.current_player_id or not self.supabase:
            return

        try:
            is_creator = False
            try:
                player_result = self.supabase.table('lobby_players').select('is_creator').eq('id', self.current_player_id).single().execute()
                is_creator = player_result.data.get('is_creator', False)
            except:
                pass

            self.supabase.table('lobby_players').delete().eq('id', self.current_player_id).execute()

            result = self.supabase.table('lobby_players').select('*').eq('lobby_id', self.current_lobby_id).execute()
            if not result.data or is_creator:
                self.supabase.table('lobby_players').delete().eq('lobby_id', self.current_lobby_id).execute()
                self.supabase.table('lobbies').delete().eq('id', self.current_lobby_id).execute()

            self.current_lobby_id = None
            self.current_player_id = None
            self.lobby_detail_widget.hide()
            self.btn_leave_lobby.hide()
            self.btn_start_game.hide()

            if hasattr(self, 'lobby_detail_timer'):
                self.lobby_detail_timer.stop()

            self.refresh_lobbies()
            QMessageBox.information(self, "Lobby quitté", "Vous avez quitté le lobby")

        except Exception as e:
            QMessageBox.critical(self, "Erreur", f"Erreur en quittant: {str(e)}")

    def start_game(self):
        if not self.current_lobby_id or not self.supabase:
            return

        try:
            lobby_result = self.supabase.table('lobbies').select('*, lobby_players(*)').eq('id', self.current_lobby_id).single().execute()
            lobby = lobby_result.data
            players = lobby.get('lobby_players', [])
            set_code = lobby.get('set_code', 'blb')

            if len(players) != lobby['max_players']:
                QMessageBox.warning(self, "Erreur", "Le lobby n'est pas complet")
                return

            self.supabase.table('lobbies').update({'status': 'in_progress'}).eq('id', self.current_lobby_id).execute()

            draft_data = {
                'lobby_id': self.current_lobby_id,
                'set_code': set_code,
                'total_rounds': 3,
                'current_round': 1,
                'status': 'active'
            }
            draft_result = self.supabase.table('draft_sessions').insert(draft_data).execute()
            draft_session = draft_result.data[0]
            draft_session_id = draft_session['id']

            for round_num in range(1, 4):
                for player in players:
                    pack_cards = self._generate_draft_pack_for_set(set_code)
                    pack_data = {
                        'draft_session_id': draft_session_id,
                        'player_id': player['id'],
                        'round_number': round_num,
                        'cards': pack_cards,
                        'current_position': player['seat_position']
                    }
                    self.supabase.table('draft_packs').insert(pack_data).execute()

            QMessageBox.information(self, "Draft lancé",
                f"Le draft a été lancé avec l'extension {set_code.upper()}!\n\n"
                f"Session ID: {draft_session_id}\n"
                f"Nombre de joueurs: {len(players)}\n"
                f"Boosters générés: {len(players) * 3}")
            self.btn_start_game.hide()

            self.tabs.setCurrentIndex(2)

        except Exception as e:
            QMessageBox.critical(self, "Erreur", f"Erreur au lancement: {str(e)}")

    def cleanup_abandoned_lobbies(self):
        if not self.supabase:
            return

        try:
            self.supabase.rpc('cleanup_abandoned_lobbies').execute()
            print("Nettoyage des lobbies abandonnés effectué")
        except Exception as e:
            print(f"Erreur nettoyage: {e}")


# execution directe pour test
if __name__ == "__main__":
    app = QApplication([])
    w = MainWindow()
    w.show()
    app.exec()
