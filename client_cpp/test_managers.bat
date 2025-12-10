@echo off
echo ==================================
echo Testing Basilic C++ Managers
echo ==================================
echo.

echo Configuring CMake...
if exist build_test_mgr rmdir /s /q build_test_mgr
mkdir build_test_mgr
cd build_test_mgr

cmake .. -G "MinGW Makefiles" -DCMAKE_BUILD_TYPE=Debug >nul 2>&1
if errorlevel 1 (
    echo CMake configuration failed!
    pause
    exit /b 1
)

echo.
echo Building test executable...
cmake --build . --target test_managers -- -j4

if errorlevel 1 (
    echo Build failed!
    pause
    exit /b 1
)

echo.
echo Running tests...
echo ==================================
test_managers.exe

echo ==================================
echo.

cd ..
pause
