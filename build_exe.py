import PyInstaller.__main__
import sys
from pathlib import Path

project_root = Path(__file__).parent
client_py = project_root / "client_py"

PyInstaller.__main__.run([
    str(client_py / "main.py"),
    '--name=Basilic',
    '--onefile',
    '--windowed',
    f'--add-data={project_root / ".env"}{";." if sys.platform == "win32" else ":"}.',
    f'--add-data={client_py / "ui"}{";ui" if sys.platform == "win32" else ":"}ui',
    '--icon=NONE',
    '--clean',
    '--noconfirm',
])
