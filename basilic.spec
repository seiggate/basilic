# -*- mode: python ; coding: utf-8 -*-


a = Analysis(
    ['C:\\Users\\Utilisateur\\Documents\\GitHub\\basilic\\client_py\\main.py'],
    pathex=[],
    binaries=[],
    datas=[('C:\\Users\\Utilisateur\\Documents\\GitHub\\basilic\\.env', '.'), ('C:\\Users\\Utilisateur\\Documents\\GitHub\\basilic\\client_py\\ui', 'ui')],
    hiddenimports=[],
    hookspath=[],
    hooksconfig={},
    runtime_hooks=[],
    excludes=[],
    noarchive=False,
    optimize=0,
)
pyz = PYZ(a.pure)

exe = EXE(
    pyz,
    a.scripts,
    a.binaries,
    a.datas,
    [],
    name='Basilic',
    debug=False,
    bootloader_ignore_signals=False,
    strip=False,
    upx=True,
    upx_exclude=[],
    runtime_tmpdir=None,
    console=False,
    disable_windowed_traceback=False,
    argv_emulation=False,
    target_arch=None,
    codesign_identity=None,
    entitlements_file=None,
    icon='NONE',
)
