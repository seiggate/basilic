# client_py/ui/main_window.py
import os
import random
import sqlite3
from math import ceil
from pathlib import Path

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


# execution directe pour test
if __name__ == "__main__":
    app = QApplication([])
    w = MainWindow()
    w.show()
    app.exec()
