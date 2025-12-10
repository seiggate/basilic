#!/bin/bash

set -e

echo "🔨 Building Basilic C++/Qt Client"
echo ""

if [ ! -d "build" ]; then
    echo "📁 Creating build directory..."
    mkdir build
fi

cd build

echo "⚙️  Running CMake..."
cmake ..

echo "🔧 Compiling..."
cmake --build . -j$(nproc 2>/dev/null || echo 4)

echo ""
echo "✅ Build complete!"
echo ""
echo "Run the application with:"
echo "  cd build && ./Basilic"
