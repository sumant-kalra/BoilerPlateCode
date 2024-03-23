cmake_minimum_required(VERSION 3.6)
project(ScientificComputing VERSION 1.0.0)

# Set the default build type
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE "Release")
    message("[DEV_LOG] No build type is provided. Release build is set as default.\n")
endif()

# Define the MACROS conditioned to the build type
if(CMAKE_BUILD_TYPE STREQUAL "Release")
    add_compile_definitions(PR_RELEASE=1)
    message("[DEV_LOG] This is a Release build.")
elseif(CMAKE_BUILD_TYPE STREQUAL "Debug")
    add_compile_definitions(PR_RELEASE=0)
    message("[DEV_LOG] This is a Debug build.")
endif()

# Identify the platform
if(APPLE)
  message("[DEV_LOG] This is MAC OSX.")
elseif(UNIX AND NOT APPLE) # NOT APPLE Condition is redundant but kept only for safety
  message("[DEV_LOG] This is Linux system")
elseif(WIN32)
  message(FATAL_ERROR "Windows OS detected! This project is not set for windows OS")
endif()

# Set compiler flags
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Werror -std=c++17 -save-temps")
set(CMAKE_CXX_FLAGS_DEBUG "-g")
set(CMAKE_CXX_FLAGS_RELEASE "-O2")

# Add libraries with source code
add_subdirectory(Libraries/Timer)
add_subdirectory(Libraries/MemoryTrace)

# Define the target
# Note that the list of files can also be attracted in a list using file() command but that approach is not recommended
# because it will not require an update in CMakeLists.txt even when new files are added. In IDEs with automated cmake build
# it will not rerun the cmake again, which is error prone.
# file(GLOB_RECURSE SRC_FILES ${PROJECT_SOURCE_DIR}/src/*)
# add_executable(runProgram ${SRC_FILES})
add_executable(runProgram src/Main.cpp
                          src/lec8/Main1.cpp
                          src/lec7/Main1.cpp
                          src/lec7/Main2.cpp
                          src/lec5/Main1.cpp
                          src/lec5/Main2.cpp
                          src/lec5/Main3.cpp
                          src/lec7/Main3.cpp)

# Link libraries with pre-build binaries
# Add include directories of libraries 
if(APPLE)
  target_link_libraries(runProgram 
                          PUBLIC "${PROJECT_SOURCE_DIR}/Libraries_MACOS/GSL/lib/libgsl.a"
                          PUBLIC "${PROJECT_SOURCE_DIR}/Libraries_MACOS/GSL/lib/libgslcblas.a"
                          PUBLIC "${PROJECT_SOURCE_DIR}/Libraries_MACOS/OPENMPI/lib/libmpi.a"
                          PUBLIC "${PROJECT_SOURCE_DIR}/Libraries_MACOS/OPENMPI/lib/libompitrace.a"
                          PUBLIC "${PROJECT_SOURCE_DIR}/Libraries_MACOS/OPENMPI/lib/libopen-pal.a"
                          PUBLIC "${PROJECT_SOURCE_DIR}/Libraries_MACOS/OPENMPI/lib/libopen-rte.a"
                          PUBLIC "${PROJECT_SOURCE_DIR}/Libraries_MACOS/HDF5/lib/libz.a"
                          PUBLIC "${PROJECT_SOURCE_DIR}/Libraries_MACOS/HDF5/lib/libhdf5_hl.a"
                          PUBLIC "${PROJECT_SOURCE_DIR}/Libraries_MACOS/HDF5/lib/libhdf5.a")
  target_include_directories(runProgram 
                              PUBLIC "${PROJECT_SOURCE_DIR}/Libraries_MACOS/GSL/include"
                              PUBLIC "${PROJECT_SOURCE_DIR}/Libraries_MACOS/OPENMPI/include"
                              PUBLIC "${PROJECT_SOURCE_DIR}/Libraries_MACOS/HDF5/include")
elseif(UNIX AND NOT APPLE)
  target_link_libraries(runProgram 
                          PUBLIC "${PROJECT_SOURCE_DIR}/Libraries_Linux/GSL/lib/libgsl.a"
                          PUBLIC "${PROJECT_SOURCE_DIR}/Libraries_Linux/GSL/lib/libgslcblas.a"
			                    PUBLIC "${PROJECT_SOURCE_DIR}/Libraries_Linux/HDF5/lib/libz.a"
			                    PUBLIC "${PROJECT_SOURCE_DIR}/Libraries_Linux/HDF5/lib/libhdf5_hl.a"
			                    PUBLIC "${PROJECT_SOURCE_DIR}/Libraries_Linux/HDF5/lib/libhdf5.a")
  target_include_directories(runProgram 
                              PUBLIC "${PROJECT_SOURCE_DIR}/Libraries_Linux/GSL/include"
                  			      PUBLIC "${PROJECT_SOURCE_DIR}/Libraries_Linux/HDF5/include")
endif()

# Link libraries with source code to the target
target_include_directories(runProgram PUBLIC "${PROJECT_SOURCE_DIR}/Libraries/rarray/include")
target_link_libraries(runProgram PUBLIC Timer)
target_link_libraries(runProgram PUBLIC MemoryTrace)
