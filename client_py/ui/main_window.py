# client_py/ui/main_window.py
import os
import random
import sqlite3
import string
import socket
import json
from math import ceil
from pathlib import Path
from threading import Thread

import requests
from PySide6.QtCore import Qt
from PySide6.QtGui import QPixmap
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
)

# chemin vers la DB
DB_PATH = Path(__file__).parent.parent / "database" / "basilic.db"
# dossier de cache pour images du booster
CACHE_DIR = Path(__file__).parent.parent / "cache_booster"
CACHE_DIR.mkdir(parents=True, exist_ok=True)


class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Basilic")
        self.resize(1200, 700)

        # onglets
        self.tabs = QTabWidget()
        self.setCentralWidget(self.tabs)

        # setup
        self._setup_library_tab()
        self._setup_booster_tab()
        self._setup_simulate_tab()
        self._setup_lobby_tab()

        self.draft_state = None
        self.lobby_state = None

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
        """Charge les cartes depuis la base et stocke image_url et mana_cost."""
        conn = sqlite3.connect(DB_PATH)
        c = conn.cursor()
        # On tente de récupérer color_identity si présent (non nécessaire ici)
        try:
            c.execute(
                """
                SELECT name, mana_cost, type_line, rarity, set_code, image_url, color_identity
                FROM cards
                ORDER BY name
                """
            )
            rows = c.fetchall()
            self.has_color_identity = True
        except sqlite3.OperationalError:
            c.execute(
                """
                SELECT name, mana_cost, type_line, rarity, set_code, image_url
                FROM cards
                ORDER BY name
                """
            )
            rows_basic = c.fetchall()
            # normalise la forme : ajoute champ vide pour color_identity
            rows = [(*r, "") for r in rows_basic]
            self.has_color_identity = False
        conn.close()

        self.table.setRowCount(len(rows))
        self.card_images = []
        self.card_mana_costs = []  # pour filtrer par couleur si besoin
        self.card_color_ids = []

        for i, row in enumerate(rows):
            name = row[0] or ""
            mana_cost = row[1] or ""
            type_line = row[2] or ""
            rarity = row[3] or ""
            set_code = row[4] or ""
            image_url = row[5] or ""
            color_identity = row[6] or ""

            self.table.setItem(i, 0, QTableWidgetItem(name))
            self.table.setItem(i, 1, QTableWidgetItem(mana_cost))
            self.table.setItem(i, 2, QTableWidgetItem(type_line))
            self.table.setItem(i, 3, QTableWidgetItem(rarity))
            self.table.setItem(i, 4, QTableWidgetItem(set_code))

            self.card_images.append(image_url)
            self.card_mana_costs.append(str(mana_cost))
            self.card_color_ids.append(str(color_identity))

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
    def _try_fetch_with_ci(self, where_clause="", params=()):
        """Tente de récupérer name, rarity, mana_cost, color_identity (si existant)."""
        conn = sqlite3.connect(DB_PATH)
        c = conn.cursor()
        try:
            sql = "SELECT name, rarity, mana_cost, color_identity FROM cards " + where_clause
            c.execute(sql, params)
            rows = c.fetchall()
            conn.close()
            return rows
        except sqlite3.OperationalError:
            conn.close()
            return None

    def _fetch_basic(self, where_clause="", params=()):
        """Récupère name, rarity, mana_cost et ajoute color_identity vide si absent."""
        conn = sqlite3.connect(DB_PATH)
        c = conn.cursor()
        sql = "SELECT name, rarity, mana_cost FROM cards " + where_clause
        c.execute(sql, params)
        rows = c.fetchall()
        conn.close()
        return [(n, r, m, "") for (n, r, m) in rows]

    def fetch_cards(self, where_clause="", params=()):
        """
        Retourne tuples (name, rarity, mana_cost, color_identity) si possible,
        sinon color_identity est vide.
        """
        rows = self._try_fetch_with_ci(where_clause, params)
        if rows is not None:
            # rows already have (name, rarity, mana_cost, color_identity)
            return rows
        return self._fetch_basic(where_clause, params)

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
        # charge pools (rows have: name, rarity, mana_cost, color_identity_or_empty)
        commons_raw = self.fetch_cards("WHERE rarity='common'")
        uncommons_raw = self.fetch_cards("WHERE rarity='uncommon'")
        rares_raw = self.fetch_cards("WHERE rarity='rare'")
        mythics_raw = self.fetch_cards("WHERE rarity='mythic'")
        basics_raw = self.fetch_cards("WHERE type_line LIKE '%Basic Land%'")

        # the_list attempt (adjust if you have a specific way to identify it)
        the_list_raw = self.fetch_cards("WHERE set_code='SLD' OR set_code='LIST'")

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
        conn = sqlite3.connect(DB_PATH)
        c = conn.cursor()
        try:
            c.execute("SELECT image_url FROM cards WHERE name = ? LIMIT 1", (name,))
            row = c.fetchone()
            conn.close()
            if row and row[0]:
                return row[0]
        except Exception:
            conn.close()
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
        commons_raw = self.fetch_cards("WHERE rarity='common'")
        uncommons_raw = self.fetch_cards("WHERE rarity='uncommon'")
        rares_raw = self.fetch_cards("WHERE rarity='rare'")
        mythics_raw = self.fetch_cards("WHERE rarity='mythic'")

        commons_simple = [(n, r) for (n, r, m, ci) in commons_raw]
        uncommons_simple = [(n, r) for (n, r, m, ci) in uncommons_raw]
        rares_simple = [(n, r) for (n, r, m, ci) in rares_raw]
        mythics_simple = [(n, r) for (n, r, m, ci) in mythics_raw]

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
    def _setup_lobby_tab(self):
        lobby_widget = QWidget()
        main_layout = QVBoxLayout(lobby_widget)
        main_layout.setSpacing(20)
        main_layout.setContentsMargins(40, 40, 40, 40)

        title = QLabel("Lobby LAN")
        title.setStyleSheet("font-size: 18px; font-weight: bold; color: #333;")
        main_layout.addWidget(title)

        self.lobby_status_label = QLabel("Aucun lobby actif")
        self.lobby_status_label.setStyleSheet("font-size: 14px; color: #666; padding: 10px;")
        main_layout.addWidget(self.lobby_status_label)

        button_layout = QHBoxLayout()
        button_layout.setSpacing(15)

        create_btn = QPushButton("Créer un Lobby")
        create_btn.setFixedSize(200, 50)
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
            QPushButton:pressed {
                background: #3d8b40;
            }
        """)
        create_btn.clicked.connect(self.create_lobby)

        join_btn = QPushButton("Rejoindre un Lobby")
        join_btn.setFixedSize(200, 50)
        join_btn.setStyleSheet("""
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
            QPushButton:pressed {
                background: #0956cc;
            }
        """)
        join_btn.clicked.connect(self.join_lobby)

        button_layout.addWidget(create_btn)
        button_layout.addWidget(join_btn)
        button_layout.addStretch()

        main_layout.addLayout(button_layout)

        self.lobby_info = QLabel("")
        self.lobby_info.setStyleSheet("""
            font-size: 12px;
            color: #333;
            padding: 15px;
            background: #f5f5f5;
            border-radius: 6px;
            min-height: 100px;
        """)
        self.lobby_info.setWordWrap(True)
        main_layout.addWidget(self.lobby_info)

        main_layout.addStretch()

        self.tabs.addTab(lobby_widget, "Lobby")

    def create_lobby(self):
        code = ''.join(random.choices(string.ascii_uppercase + string.digits, k=5))
        self.lobby_state = {
            'code': code,
            'role': 'host',
            'players': [self._get_hostname()],
            'port': 9999
        }

        self.lobby_status_label.setText(f"Code du lobby: {code}")
        info_text = f"""
Lobby créé avec succès!

Code: {code}
Rôle: Hôte
Port: {self.lobby_state['port']}

Adresse IP locale: {self._get_local_ip()}

En attente de joueurs...
        """
        self.lobby_info.setText(info_text)

        Thread(target=self._start_server, daemon=True).start()

    def join_lobby(self):
        code, ok = QInputDialog.getText(self, "Rejoindre un Lobby", "Entrez le code du lobby:")
        if ok and code:
            code = code.upper().strip()
            if len(code) == 5:
                try:
                    ip, ok2 = QInputDialog.getText(self, "Adresse IP",
                                                    "Entrez l'adresse IP de l'hôte:")
                    if ok2 and ip:
                        self.lobby_state = {
                            'code': code,
                            'role': 'client',
                            'host_ip': ip,
                            'port': 9999,
                            'player_name': self._get_hostname()
                        }

                        Thread(target=self._connect_to_server, daemon=True).start()

                        info_text = f"""
Tentative de connexion...

Code: {code}
Adresse IP: {ip}
Rôle: Client

En attente de confirmation...
                        """
                        self.lobby_info.setText(info_text)
                        self.lobby_status_label.setText(f"Connexion au lobby: {code}")
                except Exception as e:
                    QMessageBox.critical(self, "Erreur", f"Erreur de connexion: {str(e)}")
            else:
                QMessageBox.warning(self, "Code invalide", "Le code doit contenir 5 caractères")

    def _start_server(self):
        try:
            server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
            server_socket.bind(('', self.lobby_state['port']))
            server_socket.listen(7)

            while self.lobby_state and self.lobby_state.get('role') == 'host':
                try:
                    client_socket, address = server_socket.accept()
                    data = client_socket.recv(1024).decode('utf-8')
                    client_data = json.loads(data)

                    if client_data.get('code') == self.lobby_state['code']:
                        player_name = client_data.get('player_name', 'Joueur inconnu')
                        self.lobby_state['players'].append(player_name)

                        response = {'status': 'ok', 'players': self.lobby_state['players']}
                        client_socket.send(json.dumps(response).encode('utf-8'))

                        info_text = f"""
Lobby actif!

Code: {self.lobby_state['code']}
Joueurs ({len(self.lobby_state['players'])}):
{chr(10).join(f"  • {p}" for p in self.lobby_state['players'])}

Port: {self.lobby_state['port']}
                        """
                        self.lobby_info.setText(info_text)
                    else:
                        response = {'status': 'invalid_code'}
                        client_socket.send(json.dumps(response).encode('utf-8'))

                    client_socket.close()
                except Exception as e:
                    pass

            server_socket.close()
        except Exception as e:
            QMessageBox.critical(self, "Erreur Serveur", f"Erreur serveur: {str(e)}")

    def _connect_to_server(self):
        try:
            client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            client_socket.connect((self.lobby_state['host_ip'], self.lobby_state['port']))

            data = {
                'code': self.lobby_state['code'],
                'player_name': self.lobby_state['player_name']
            }
            client_socket.send(json.dumps(data).encode('utf-8'))

            response = client_socket.recv(1024).decode('utf-8')
            response_data = json.loads(response)

            if response_data.get('status') == 'ok':
                players = response_data.get('players', [])
                info_text = f"""
Connecté au lobby!

Code: {self.lobby_state['code']}
Joueurs ({len(players)}):
{chr(10).join(f"  • {p}" for p in players)}

Adresse hôte: {self.lobby_state['host_ip']}
                """
                self.lobby_info.setText(info_text)
                self.lobby_status_label.setText("Connecté au lobby")
            else:
                QMessageBox.warning(self, "Connexion échouée", "Code invalide ou lobby plein")
                self.lobby_state = None

            client_socket.close()
        except Exception as e:
            QMessageBox.critical(self, "Erreur Connexion", f"Impossible de se connecter: {str(e)}")
            self.lobby_state = None

    def _get_local_ip(self):
        try:
            s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
            s.connect(("8.8.8.8", 80))
            ip = s.getsockname()[0]
            s.close()
            return ip
        except:
            return "127.0.0.1"

    def _get_hostname(self):
        try:
            return socket.gethostname()
        except:
            return "Joueur"


# execution directe pour test
if __name__ == "__main__":
    app = QApplication([])
    w = MainWindow()
    w.show()
    app.exec()
