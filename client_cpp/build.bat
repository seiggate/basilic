@echo off

echo Building Basilic C++/Qt Client
echo.

if not exist "build" (
    echo Creating build directory...
    mkdir build
)

cd build

echo Running CMake...
cmake .. -G "Visual Studio 17 2022"
if errorlevel 1 (
    echo CMake failed! Trying with MinGW...
    cmake .. -G "MinGW Makefiles"
)

echo Compiling...
cmake --build . --config Release

echo.
echo Build complete!
echo.
echo Run the application with:
echo   cd build\Release
echo   Basilic.exe

cd ..
