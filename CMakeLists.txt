cmake_minimum_required(VERSION 3.0.0)
project(Application VERSION 1.0.0)

# Set the compiler flags 
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Werror -std=c++17 -save-temps")

# Check build type
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release)
    message(STATUS "[DEV] BUILD TYPE: Not found. Defaults to Release")
elseif(CMAKE_BUILD_TYPE STREQUAL "Release")
    add_compile_definitions(PR_RELEASE=1)
    set(CMAKE_CXX_FLAGS_RELEASE "-O3")
    message(STATUS "[DEV] Build Type: ${CMAKE_BUILD_TYPE}")
else()
    add_compile_definitions(PR_RELEASE=0)
    set(CMAKE_CXX_FLAGS_DEBUG "-g")
    message(STATUS "[DEV] Build Type: ${CMAKE_BUILD_TYPE}")
endif()

# Identify the Operating System 
if(APPLE)
    message(STATUS "[DEV] OS: MACOS")
elseif(UNIX AND NOT APPLE)
    message(STATUS "[DEV] OS: Linux")
elseif(WIN32)
    message(STATUS "[DEV] OS: Windows")
endif()

add_executable(app src/Main.cpp)
