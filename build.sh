#!/bin/bash

echo "========================================"
echo "Construction de l'exécutable Basilic"
echo "========================================"
echo ""

echo "Installation de PyInstaller si nécessaire..."
pip install pyinstaller

echo ""
echo "Construction de l'exécutable..."
python build_exe.py

echo ""
echo "========================================"
echo "Build terminé!"
echo "L'exécutable se trouve dans: dist/Basilic"
echo "========================================"
