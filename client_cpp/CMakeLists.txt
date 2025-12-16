cmake_minimum_required(VERSION 3.16)

project(Basilic VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

# Qt6 components
find_package(Qt6 REQUIRED COMPONENTS
    Core
    Widgets
    Network
    Gui
)

# Source files - Model layer
set(MODEL_SOURCES
    model/Card.cpp
    model/Set.cpp
    model/Booster.cpp
    model/Lobby.cpp
    model/LobbyPlayer.cpp
    model/Draft.cpp
    model/DraftPack.cpp
    model/PlayerPool.cpp
)

set(MODEL_HEADERS
    model/Card.h
    model/Set.h
    model/Booster.h
    model/Lobby.h
    model/LobbyPlayer.h
    model/Draft.h
    model/DraftPack.h
    model/PlayerPool.h
)

# Source files - Manager layer
set(MANAGER_SOURCES
    manager/SupabaseClient.cpp
    manager/DatabaseManager.cpp
    manager/LobbyManager.cpp
    manager/DraftManager.cpp
    manager/ImageCache.cpp
)

set(MANAGER_HEADERS
    manager/SupabaseClient.h
    manager/DatabaseManager.h
    manager/LobbyManager.h
    manager/DraftManager.h
    manager/ImageCache.h
)

# Source files - UI layer
set(UI_SOURCES
    ui/MainWindow.cpp
)

set(UI_HEADERS
    ui/MainWindow.h
)

set(UI_FORMS
    ui/MainWindow.ui
)

# Utils
set(UTILS_SOURCES
    utils/Config.cpp
)

set(UTILS_HEADERS
    utils/Config.h
)

# Main executable
add_executable(${PROJECT_NAME}
    main.cpp
    ${MODEL_SOURCES}
    ${MODEL_HEADERS}
    ${MANAGER_SOURCES}
    ${MANAGER_HEADERS}
    ${UI_SOURCES}
    ${UI_HEADERS}
    ${UI_FORMS}
    ${UTILS_SOURCES}
    ${UTILS_HEADERS}
)

# Include directories
target_include_directories(${PROJECT_NAME} PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}/model
    ${CMAKE_CURRENT_SOURCE_DIR}/manager
    ${CMAKE_CURRENT_SOURCE_DIR}/ui
    ${CMAKE_CURRENT_SOURCE_DIR}/utils
)

# Link Qt libraries
target_link_libraries(${PROJECT_NAME} PRIVATE
    Qt6::Core
    Qt6::Widgets
    Qt6::Network
    Qt6::Gui
)

# Platform-specific settings
if(WIN32)
    set_target_properties(${PROJECT_NAME} PROPERTIES
        WIN32_EXECUTABLE ON
    )
    # Copy Qt DLLs to output directory on Windows
    add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different
        $<TARGET_FILE:Qt6::Core>
        $<TARGET_FILE:Qt6::Widgets>
        $<TARGET_FILE:Qt6::Network>
        $<TARGET_FILE:Qt6::Gui>
        $<TARGET_FILE_DIR:${PROJECT_NAME}>
    )
endif()

if(APPLE)
    set_target_properties(${PROJECT_NAME} PROPERTIES
        MACOSX_BUNDLE ON
        MACOSX_BUNDLE_INFO_PLIST ${CMAKE_CURRENT_SOURCE_DIR}/Info.plist
    )
endif()

# Installation rules
install(TARGETS ${PROJECT_NAME}
    BUNDLE DESTINATION .
    RUNTIME DESTINATION bin
)

# Qt deployment
if(Qt6_FOUND)
    # Use Qt's deployment tool (windeployqt, macdeployqt)
    if(WIN32)
        find_program(WINDEPLOYQT_EXECUTABLE windeployqt HINTS "${Qt6_DIR}/../../../bin")
        if(WINDEPLOYQT_EXECUTABLE)
            add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
                COMMAND ${WINDEPLOYQT_EXECUTABLE} $<TARGET_FILE:${PROJECT_NAME}>
                COMMENT "Running windeployqt..."
            )
        endif()
    elseif(APPLE)
        find_program(MACDEPLOYQT_EXECUTABLE macdeployqt HINTS "${Qt6_DIR}/../../../bin")
        if(MACDEPLOYQT_EXECUTABLE)
            add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
                COMMAND ${MACDEPLOYQT_EXECUTABLE} $<TARGET_BUNDLE_DIR:${PROJECT_NAME}>
                COMMENT "Running macdeployqt..."
            )
        endif()
    endif()
endif()

# Test executable for models
add_executable(test_models
    test_models.cpp
    ${MODEL_SOURCES}
    ${MODEL_HEADERS}
)

target_include_directories(test_models PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}/model
)

target_link_libraries(test_models PRIVATE
    Qt6::Core
)

# Test executable for managers
add_executable(test_managers
    test_managers.cpp
    ${MODEL_SOURCES}
    ${MODEL_HEADERS}
    ${MANAGER_SOURCES}
    ${MANAGER_HEADERS}
    ${UTILS_SOURCES}
    ${UTILS_HEADERS}
)

target_include_directories(test_managers PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}/model
    ${CMAKE_CURRENT_SOURCE_DIR}/manager
    ${CMAKE_CURRENT_SOURCE_DIR}/utils
)

target_link_libraries(test_managers PRIVATE
    Qt6::Core
    Qt6::Network
)

# Copy .env file to build directory
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/../.env ${CMAKE_CURRENT_BINARY_DIR}/.env COPYONLY)

# Development build configuration
if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    message(STATUS "Building in DEBUG mode")
    target_compile_definitions(${PROJECT_NAME} PRIVATE DEBUG_BUILD)
else()
    message(STATUS "Building in RELEASE mode")
    target_compile_definitions(${PROJECT_NAME} PRIVATE RELEASE_BUILD)
endif()

# Print configuration summary
message(STATUS "")
message(STATUS "Basilic Configuration Summary:")
message(STATUS "  Version: ${PROJECT_VERSION}")
message(STATUS "  Qt Version: ${Qt6_VERSION}")
message(STATUS "  Build Type: ${CMAKE_BUILD_TYPE}")
message(STATUS "  C++ Standard: ${CMAKE_CXX_STANDARD}")
message(STATUS "")
