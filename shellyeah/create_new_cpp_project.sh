#!/bin/sh

project_directory="${DEVELOP}/${1}"

cd ${DEVELOP} && mkdir -p ${1} && cd ${project_directory} && \
touch .gitignore .gitmodules CMakeLists.txt README.md

cat > .gitignore << EOF
# Ignore build artefacts
build

# Ignore temporary files created by Google Test Framework
Testing

# Ignore .vscode config files
.vscode

# Ignore binaries
*.out
*.exe
main
app

# Ignore third-parties
external

# Ignore CMake cache
.cache
EOF

cat > .gitmodules << EOF
[submodule "external/googletest"]
	path = external/googletest
	url = https://github.com/google/googletest.git
EOF

cat > CMakeLists.txt << EOF
cmake_minimum_required(VERSION 3.29.0)
project(single_number VERSION 0.0.1
    DESCRIPTION "$1"
    LANGUAGES CXX)

# Disable response files
set(CMAKE_CXX_USE_RESPONSE_FILE_FOR_INCLUDES OFF)

# Enable C++20 compiler support
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Update the submodules here
include(cmake/UpdateSubmodules.cmake)

# Enable testing for this project
include(CTest)

# Add subdirectories with code
add_subdirectory(external)
add_subdirectory(test)
add_subdirectory(src)
EOF

cd ${project_directory} && mkdir -p build cmake external src test && \
cd ${project_directory}/cmake && touch UpdateSubmodules.cmake

cat > UpdateSubmodules.cmake << EOF
# Adapted from https://cliutils.gitlab.io/modern-cmake/chapters/projects/submodule.html
find_package(Git QUIET)
if(GIT_FOUND)
    option(UPDATE_SUBMODULES "Check submodules during build" ON)
    if(NOT UPDATE_SUBMODULES)
        return()
    endif()
    execute_process(COMMAND \${GIT_EXECUTABLE} submodule
                    WORKING_DIRECTORY \${CMAKE_CURRENT_SOURCE_DIR}
                    OUTPUT_VARIABLE EXISTING_SUBMODULES
                    RESULT_VARIABLE RETURN_CODE
                    OUTPUT_STRIP_TRAILING_WHITESPACE)
    message(STATUS "Updating git submodules:\n\${EXISTING_SUBMODULES}")
    execute_process(COMMAND \${GIT_EXECUTABLE} submodule update --init --recursive
                    WORKING_DIRECTORY \${CMAKE_CURRENT_SOURCE_DIR}
                    RESULT_VARIABLE RETURN_CODE)
    if(NOT RETURN_CODE EQUAL "0")
        message(WARNING "Cannot update submodules. Git command failed with \${RETURN_CODE}")
        return()
    endif()
    message(STATUS "Git submodules updated successfully")
endif()
EOF

cd ${project_directory}/external && touch CMakeLists.txt
cat > CMakeLists.txt << EOF
cmake_minimum_required(VERSION 3.29.0)

set(CMAKE_CXX_STANDARD 20)
add_subdirectory(googletest)
EOF

cd ${project_directory}/src && touch CMakeLists.txt main.cpp solution.cpp solution.h
cat > CMakeLists.txt << EOF
cmake_minimum_required(VERSION 3.29.0)

set(SOURCES solution.h solution.cpp main.cpp)
add_executable(app \${SOURCES})
EOF

cat > main.cpp << EOF
#include "solution.h"

int main() {
    // TODO: put some code here
}
EOF

cat > solution.h << EOF
#ifndef DINO_SOURCE_${1^^}_H
#define DINO_SOURCE_${1^^}_H

#include <vector>


class Solution {
public:
    ${2} ${3};
};

#endif // DINO_SOURCE_${1^^}_H
EOF

cat > solution.cpp << EOF
#include "solution.h"

${2} Solution::${3} {
    // your code goes here
}
EOF

cd ${project_directory}/test && touch CMakeLists.txt
cd ${project_directory}/test && touch $1_test.cpp
cat > CMakeLists.txt << EOF
cmake_minimum_required(VERSION 3.29.0)

# Enable C++20 compiler support
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

set(test_solution "$1_test")

# BUILD_TESTING variable is created by include(CTest)
# It is set to ON by default
if (BUILD_TESTING)
    set(SOURCES
        "../src/solution.h"
        "../src/solution.cpp"
        "$1_test.cpp")

    add_executable(\${test_solution} \${SOURCES})

    target_link_libraries(\${test_solution} PRIVATE GTest::gtest_main)

    include(GoogleTest)
    # Finds all the Google tests associated with the executable
    gtest_discover_tests(\${test_solution})

    target_include_directories(\${test_solution} PUBLIC test src)
endif()
EOF

cat > $1_test.cpp << EOF
#include <gtest/gtest.h>
#include "../src/solution.h"


TEST(TestTopic, $1_test) {
    // your code goes here
    int actual_result {1};
    int expected_result {1};

    EXPECT_EQ(actual_result, expected_result);
}
EOF

cd ${project_directory} && touch xconfig.sh xbuild.sh xtests.sh xapp.sh

cat > xconfig.sh << EOF
# You have to define DEVELOP variable as a path to your development 
# directory in your .bashrc (or .zshrc if you use zsh) file

# Environment variables C_COMPILER and CXX_COMPILER have to be 
# defined in your .bashrc (or .zshrc if you're using zsh) file as well.
# Usually path to compiler looks like "/usr/bin/gcc" or "/usr/bin/clang".
# However, it might differ if you've installed it in other directory.

/usr/bin/cmake --no-warn-unused-cli \\
    -DCMAKE_BUILD_TYPE:STRING=Debug \\
    -DCMAKE_EXPORT_COMPILE_COMMANDS:BOOL=TRUE \\
    -DCMAKE_C_COMPILER:FILEPATH=$C_COMPILER \\
    -DCMAKE_CXX_COMPILER:FILEPATH=$CXX_COMPILER \\
    -S$DEVELOP/$1 \\
    -B$DEVELOP/$1/build \\
    -G Ninja
EOF

cat > xbuild.sh << EOF
# You have to define DEVELOP variable as a path to your development 
# directory in your .bashrc (or .zshrc if you use zsh) file

/usr/bin/cmake --build $DEVELOP/$1/build --config Debug --target all --
EOF

cat > xtests.sh << EOF
# You have to define DEVELOP variable as a path to your development 
# directory in your .bashrc (or .zshrc if you use zsh) file

$DEVELOP/$1/build/test/$1_test
EOF

cat > xapp.sh << EOF
# You have to define DEVELOP variable as a path to your development 
# directory in your .bashrc (or .zshrc if you use zsh) file

$DEVELOP/$1/build/src/app
EOF

cd ${project_directory} && \
    git init && \
    git config --global init.defaultBranch master && \
    git config --global user.email "dinosource.cpp@gmail.com" && \
    git config --global user.name "Dino Source" && \
    git config --global core.editor nvim && \
    git add --all && \
    git commit -m "Initial commit" && \
    git submodule add -f https://github.com/google/googletest.git external/googletest && \
    git add --all && \
    git commit -m "Add googletest as a git submodule" && \
    bash ./xconfig.sh && \
    bash ./xbuild.sh && \
    nvim ${project_directory}
