@echo off
echo ==================================
echo Testing Basilic C++ Models
echo ==================================

REM Create build directory
if not exist build_test mkdir build_test
cd build_test

REM Configure with CMake
echo.
echo Configuring CMake...
cmake .. -DCMAKE_BUILD_TYPE=Debug

REM Build only the test executable
echo.
echo Building test executable...
cmake --build . --target test_models --config Debug

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
