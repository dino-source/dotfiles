#!/bin/sh

DEVELOP="${HOME}/dev/cpp"

project_directory="${DEVELOP}/${1}"

cd ${DEVELOP} && mkdir -p ${1} && cd ${project_directory} && \
touch .gitignore .gitmodules CMakeLists.txt README.md

cat > .gitignore << EOF
# Ignore build artefacts in 'build' directory
build/

# Ignore 'lib' directory
lib/

# Ignore temporary files created by Google Test Framework in 'Testing' directory
Testing/

# Ignore VS Code config files in '.vscode' directory
.vscode/

# Ignore binaries
*.out
*.exe
main
app

# Ignore third-parties in 'external' directory in the root of the project
/external/*

# except of CMakeLists.txt file
!/external/CMakeLists.txt

#Ignore googletest
googletest
/external/googletest/

# Ignore unnecessary CMake, Make, clangd and conan stuff
.cache/
CMakeFiles/
CMakeCache.txt
DartConfiguration.tcl

*.cmake
!/cmake/UpdateSubmodules.cmake
Makefile
compile_commands.json
EOF

cat > .gitmodules << EOF
[submodule "external/googletest"]
	path = external/googletest
	url = https://github.com/google/googletest.git
EOF

cat > CMakeLists.txt << EOF
cmake_minimum_required(VERSION 3.30.0)
project("$1" VERSION 0.0.1
    DESCRIPTION "$1"
    LANGUAGES CXX)

# Disable response files
set(CMAKE_CXX_USE_RESPONSE_FILE_FOR_INCLUDES OFF)

# Enable C++23 compiler support
set(CMAKE_CXX_STANDARD 23)
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

cd ${project_directory} && mkdir -p .vscode && cd ${project_directory}/.vscode && \
touch launch.json

cat > launch.json << EOF
{
    "version": "0.2.0",
    "configurations": [
        {
            "type": "lldb",
            "request": "launch",
            "name": "Debug",
            "program": "\${workspaceFolder}/build/test/${1}_test",
            "args": [],
            "cwd": "\${workspaceFolder}"
        }
    ]
}
EOF

cd ${project_directory}/external && touch CMakeLists.txt
cat > CMakeLists.txt << EOF
cmake_minimum_required(VERSION 3.30.0)

set(CMAKE_CXX_STANDARD 23)
add_subdirectory(googletest)
EOF

cd ${project_directory}/src && touch CMakeLists.txt main.cpp solution.h btree.h
cat > CMakeLists.txt << EOF
cmake_minimum_required(VERSION 3.30.0)

set(SOURCES solution.h main.cpp)
add_executable(app \${SOURCES})
EOF

cat > main.cpp << EOF
int main() {}
EOF

cat > btree.h << EOF
struct TreeNode {
    int val;
    TreeNode* left;
    TreeNode* right;

    TreeNode()
        : val{0}
        , left{nullptr}
        , right{nullptr} {}

    explicit TreeNode(int x)
        : val{x}
        , left{nullptr}
        , right{nullptr} {}

    TreeNode(int x, TreeNode* left, TreeNode* right)
        : val{x}
        , left{left}
        , right{right} {}
};
EOF

cat > solution.h << EOF
#ifndef DINO_SOURCE_${1^^}_H
#define DINO_SOURCE_${1^^}_H

#include "btree.h"
#include <string>
#include <vector>

class Solution {
public:
    auto ${2} {
        return {};
    }
};

#endif // DINO_SOURCE_${1^^}_H
EOF

cd ${project_directory}/test && touch CMakeLists.txt
cd ${project_directory}/test && touch $1_test.cpp
cat > CMakeLists.txt << EOF
cmake_minimum_required(VERSION 3.30.0)

# Enable C++23 compiler support
set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

set(TEST_SOLUTION "$1_test")

# BUILD_TESTING variable is created by include(CTest)
# It is set to ON by default
if (BUILD_TESTING)
    set(SOURCES
        "../src/solution.h"
        "$1_test.cpp")

    add_executable(\${TEST_SOLUTION} \${SOURCES})

    target_link_libraries(\${TEST_SOLUTION} PRIVATE GTest::gtest_main)

    include(GoogleTest)
    # Finds all the Google tests associated with the executable
    gtest_discover_tests(\${TEST_SOLUTION})

    target_include_directories(\${TEST_SOLUTION} PUBLIC test src)
endif()
EOF

cat > $1_test.cpp << EOF
#include <gtest/gtest.h>
#include "../src/solution.h"

[[maybe_unused]] Solution sol;

TEST(TestTopic, $1_test_1) {
    auto actual_result {1};
    auto expected_result {1};

    EXPECT_EQ(actual_result, expected_result);
}

TEST(TestTopic, $1_test_2) {
    auto actual_result {1};
    auto expected_result {1};

    EXPECT_EQ(actual_result, expected_result);
}

TEST(TestTopic, $1_test_3) {
    auto actual_result {1};
    auto expected_result {1};

    EXPECT_EQ(actual_result, expected_result);
}
EOF

cd ${project_directory} && touch xconfig.sh xbuild.sh xtests.sh xapp.sh

cat > xconfig.sh << EOF
# You have to define DEVELOP variable as a path to your development 
# directory in your .bashrc (or .zshrc if you use zsh) file

# Environment variables CC and CXX have to be defined in your .bashrc
# (or .zshrc if you're using zsh) file as well.
# Usually path to compiler looks like "/usr/bin/gcc" or "/usr/bin/clang".
# However, it might differ if you've installed it in other directory.

/usr/bin/cmake --no-warn-unused-cli \\
    -DCMAKE_BUILD_TYPE:STRING=Debug \\
    -DCMAKE_EXPORT_COMPILE_COMMANDS:BOOL=TRUE \\
    -DCMAKE_C_COMPILER:FILEPATH=\$CC \\
    -DCMAKE_CXX_COMPILER:FILEPATH=\$CXX \\
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
