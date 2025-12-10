# Compiler Setup Guide

## Automatic Detection

The build scripts now automatically detect which compiler to use:
1. **Visual Studio 2022** (preferred)
2. **MinGW** (fallback)

## Option 1: Visual Studio (Recommended)

Install Visual Studio Build Tools or Visual Studio 2022 Community:
- Download: https://visualstudio.microsoft.com/downloads/
- Select "Desktop development with C++"

## Option 2: MinGW (Included with Qt)

MinGW is typically installed with Qt. Find your MinGW installation:

```
C:\Qt\Tools\mingw1310_64\bin\mingw32-make.exe
```

**If your MinGW version is different**, update the path in both scripts:

**test_build.bat** and **build.bat**, line 8:
```batch
set "MINGW_DIR=C:\Qt\Tools\mingw1310_64"
```

### Finding your MinGW version:
```batch
dir C:\Qt\Tools
```

Look for folders like:
- `mingw1120_64` (MinGW 11.2.0)
- `mingw1310_64` (MinGW 13.1.0)
- etc.

## Testing

After setup, try:
```batch
rmdir /s /q build_test
.\test_build.bat
```

## Troubleshooting

**Error: "mingw32-make not found"**
- Update `MINGW_DIR` in the batch files
- OR install Visual Studio Build Tools

**Error: "Visual Studio not found"**
- The script will automatically try MinGW
- Make sure MinGW path is correct
