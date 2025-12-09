@echo off
echo ========================================
echo Construction de l'executable Basilic
echo ========================================
echo.

echo Installation de PyInstaller si necessaire...
pip install pyinstaller

echo.
echo Construction de l'executable...
python build_exe.py

echo.
echo ========================================
echo Build termine!
echo L'executable se trouve dans: dist\Basilic.exe
echo ========================================
pause
