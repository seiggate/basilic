@echo off
echo ==================================
echo Testing Basilic C++ Models
echo ==================================

REM Set Qt6 path
set "QT_DIR=C:\Qt\6.10.1\mingw_64"
set "MINGW_DIR=C:\Qt\Tools\mingw1310_64"
set "PATH=%MINGW_DIR%\bin;%QT_DIR%\bin;%PATH%"
set "Qt6_DIR=%QT_DIR%\lib\cmake\Qt6"
set "CMAKE_PREFIX_PATH=%QT_DIR%"

REM Create build directory
if not exist build_test mkdir build_test
cd build_test

REM Configure with CMake - Try Visual Studio first, then MinGW
echo.
echo Configuring CMake...
cmake .. -G "Visual Studio 17 2022" -DCMAKE_PREFIX_PATH=%CMAKE_PREFIX_PATH% -DQt6_DIR=%Qt6_DIR% >nul 2>&1
if errorlevel 1 (
    echo Visual Studio not found, trying MinGW...
    cmake .. -G "MinGW Makefiles" -DCMAKE_BUILD_TYPE=Debug -DCMAKE_PREFIX_PATH=%CMAKE_PREFIX_PATH% -DQt6_DIR=%Qt6_DIR%
    set "USE_MINGW=1"
) else (
    echo Using Visual Studio 2022
    set "USE_MINGW=0"
)

REM Build only the test executable
echo.
echo Building test executable...
if "%USE_MINGW%"=="1" (
    mingw32-make test_models
) else (
    cmake --build . --target test_models --config Debug
)

REM Run tests if build succeeded
if %ERRORLEVEL% EQU 0 (
    echo.
    echo Running tests...
    echo ==================================
    if "%USE_MINGW%"=="1" (
        test_models.exe
    ) else (
        Debug\test_models.exe
    )
    echo ==================================
) else (
    echo.
    echo Build failed!
    exit /b 1
)

cd ..
