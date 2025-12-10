@echo off
echo ==================================
echo Testing Basilic C++ Models
echo ==================================

REM Set Qt6 path
set "QT_DIR=C:\Qt\6.10.1\mingw_64"
set "PATH=%QT_DIR%\bin;%PATH%"
set "Qt6_DIR=%QT_DIR%\lib\cmake\Qt6"
set "CMAKE_PREFIX_PATH=%QT_DIR%"

REM Create build directory
if not exist build_test mkdir build_test
cd build_test

REM Configure with CMake
echo.
echo Configuring CMake...
cmake .. -G "MinGW Makefiles" -DCMAKE_BUILD_TYPE=Debug -DCMAKE_PREFIX_PATH=%CMAKE_PREFIX_PATH% -DQt6_DIR=%Qt6_DIR%

REM Build only the test executable
echo.
echo Building test executable...
mingw32-make test_models

REM Run tests if build succeeded
if %ERRORLEVEL% EQU 0 (
    echo.
    echo Running tests...
    echo ==================================
    Debug\test_models.exe
    echo ==================================
) else (
    echo.
    echo Build failed!
    exit /b 1
)

cd ..
