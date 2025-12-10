@echo off

echo Building Basilic C++/Qt Client
echo.

REM Set Qt6 path
set "QT_DIR=C:\Qt\6.10.1\mingw_64"
set "MINGW_DIR=C:\Qt\Tools\mingw1310_64"
set "PATH=%MINGW_DIR%\bin;%QT_DIR%\bin;%PATH%"
set "Qt6_DIR=%QT_DIR%\lib\cmake\Qt6"
set "CMAKE_PREFIX_PATH=%QT_DIR%"

if not exist "build" (
    echo Creating build directory...
    mkdir build
)

cd build

echo Running CMake...
cmake .. -G "Visual Studio 17 2022" -DCMAKE_PREFIX_PATH=%CMAKE_PREFIX_PATH% -DQt6_DIR=%Qt6_DIR% >nul 2>&1
if errorlevel 1 (
    echo Visual Studio not found, trying MinGW...
    cmake .. -G "MinGW Makefiles" -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH=%CMAKE_PREFIX_PATH% -DQt6_DIR=%Qt6_DIR%
    set "USE_MINGW=1"
) else (
    echo Using Visual Studio 2022
    set "USE_MINGW=0"
)

echo Compiling...
if "%USE_MINGW%"=="1" (
    mingw32-make
) else (
    cmake --build . --config Release
)

echo.
echo Build complete!
echo.
echo Run the application with:
echo   cd build\Release
echo   Basilic.exe

cd ..
