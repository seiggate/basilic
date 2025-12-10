#!/bin/bash

echo "=================================="
echo "Testing Basilic C++ Models"
echo "=================================="

# Create build directory
mkdir -p build_test
cd build_test

# Configure with CMake
echo ""
echo "Configuring CMake..."
cmake .. -DCMAKE_BUILD_TYPE=Debug

# Build only the test executable
echo ""
echo "Building test executable..."
cmake --build . --target test_models

# Run tests if build succeeded
if [ $? -eq 0 ]; then
    echo ""
    echo "Running tests..."
    echo "=================================="
    ./test_models
    echo "=================================="
else
    echo ""
    echo "Build failed!"
    exit 1
fi
