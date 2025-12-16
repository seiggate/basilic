@echo off

echo Building Basilic C++/Qt Client
echo.

REM Set Qt6 path
set "QT_DIR=C:\Qt\6.10.1\mingw_64"
set "MINGW_DIR=C:\Qt\Tools\mingw1310_64"
set "PATH=%MINGW_DIR%\bin;%QT_DIR%\bin;%PATH%"
set "Qt6_DIR=%QT_DIR%\lib\cmake\Qt6"
set "CMAKE_PREFIX_PATH=%QT_DIR%"

REM Clean build directory to avoid CMake cache conflicts
if exist "build" (
    echo Cleaning old build directory...
    rmdir /s /q build
)

echo Creating build directory...
mkdir build

cd build

echo Running CMake with MinGW...
cmake .. -G "MinGW Makefiles" -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH=%CMAKE_PREFIX_PATH% -DQt6_DIR=%Qt6_DIR%

echo Compiling...
mingw32-make

echo.
echo Build complete!
echo.
echo Run the application with:
echo   cd build
echo   Basilic.exe

cd ..
