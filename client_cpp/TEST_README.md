# 🧪 Testing Basilic C++ Models

This guide explains how to test the C++ data models independently.

## 📋 Prerequisites

- Qt6 installed (Core module minimum)
- CMake 3.16 or higher
- C++17 compatible compiler

## 🚀 Quick Test

### On Linux/Mac:
```bash
cd client_cpp
./test_build.sh
```

### On Windows:
```cmd
cd client_cpp
test_build.bat
```

## 📝 What Gets Tested

The test suite validates all 8 data models:

### 1. **Card** - Magic card representation
- Creation and validation
- JSON serialization/deserialization
- Utility methods (isMonochrome, containsColor, isBasicLand)

### 2. **Set** - Magic set/expansion
- Set information storage
- Date handling
- JSON conversion

### 3. **Booster** - Booster pack generator
- Rarity distribution constants
- Pack generation logic
- Multi-pack generation

### 4. **Lobby** - Multiplayer lobby
- Lobby creation with code
- Player management
- Capacity checks (isFull, currentPlayerCount)

### 5. **LobbyPlayer** - Player in lobby
- Player information
- Seat assignment
- Creator status

### 6. **Draft** - Draft session
- Round and pick tracking
- Direction management
- State progression (advanceRound, nextPick)

### 7. **DraftPack** - Booster in draft
- Card collection management
- Card removal
- Ownership tracking

### 8. **PlayerPool** - Drafted cards collection
- Card accumulation
- Timestamp updates
- JSON serialization

## 📊 Expected Output

If everything works, you should see:

```
===================================
Testing Basilic C++ Models
===================================

=== Test Card ===
Card Name: "Lightning Bolt"
Mana Cost: "{R}"
CMC: 1
Is Valid: true
Is Monochrome: true
Contains Red: true
JSON: {...}
Deserialized Name: "Lightning Bolt"

=== Test Set ===
...

=== Test Lobby ===
Lobby Name: "My Draft Lobby"
Lobby Code: "ABC123"
Current Players: 2
Is Full: false
...

===================================
All tests completed!
===================================
```

## 🔧 Manual Build

If the scripts don't work, build manually:

```bash
# Create build directory
mkdir -p build_test
cd build_test

# Configure
cmake .. -DCMAKE_BUILD_TYPE=Debug

# Build test executable only
cmake --build . --target test_models

# Run tests
./test_models  # Linux/Mac
# or
.\Debug\test_models.exe  # Windows
```

## 🐛 Troubleshooting

### "Qt6 not found"
Make sure Qt6 is installed and in your PATH:
```bash
# Check Qt installation
qmake --version
```

### "CMake version too old"
Update CMake to 3.16+:
```bash
cmake --version
```

### Build errors
Check that all model files exist:
```bash
ls -la model/*.cpp model/*.h
```

## 📁 Test Files

- `test_models.cpp` - Main test program
- `test_build.sh` - Linux/Mac build script
- `test_build.bat` - Windows build script
- `CMakeLists.txt` - Includes `test_models` target

## ✅ Next Steps

Once tests pass, you can:
1. Implement SupabaseClient to connect to database
2. Add DatabaseManager for CRUD operations
3. Create UI components (MainWindow, CardWidget)
4. Test full integration with Supabase backend

## 📚 Model Dependencies

```
Card (base class)
  ↓
Booster (generates Cards)
  ↓
DraftPack (contains Cards)
  ↓
PlayerPool (collects Cards)

Lobby ← LobbyPlayer (N players)
  ↓
Draft → DraftPack (N packs)
      → PlayerPool (N pools)
```

All models are independent and can be tested separately.
