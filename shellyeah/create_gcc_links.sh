#!/bin/bash

echo "Enter GCC version [ENTER]:"
read GCC_VERSION

LNK_PATH=/usr/bin
OBJ_PATH=/usr/local/gcc-${GCC_VERSION}.0/bin

sudo rm ${LNK_PATH}/c++
sudo ln -s ${OBJ_PATH}/c++-${GCC_VERSION} ${LNK_PATH}/c++

sudo rm ${LNK_PATH}/cpp
sudo ln -s ${OBJ_PATH}/cpp-${GCC_VERSION} ${LNK_PATH}/cpp

sudo rm ${LNK_PATH}/g++
sudo ln -s ${OBJ_PATH}/g++-${GCC_VERSION} ${LNK_PATH}/g++

sudo rm ${LNK_PATH}/gcc
sudo ln -s ${OBJ_PATH}/gcc-${GCC_VERSION} ${LNK_PATH}/gcc

sudo rm ${LNK_PATH}/gcc-ar
sudo ln -s ${OBJ_PATH}/gcc-ar-${GCC_VERSION} ${LNK_PATH}/gcc-ar

sudo rm ${LNK_PATH}/gcc-nm
sudo ln -s ${OBJ_PATH}/gcc-nm-${GCC_VERSION} ${LNK_PATH}/gcc-nm

sudo rm ${LNK_PATH}/gcc-ranlib
sudo ln -s ${OBJ_PATH}/gcc-ranlib-${GCC_VERSION} ${LNK_PATH}/gcc-ranlib

sudo rm ${LNK_PATH}/gcov
sudo ln -s ${OBJ_PATH}/gcov-${GCC_VERSION} ${LNK_PATH}/gcov

sudo rm ${LNK_PATH}/gcov-dump
sudo ln -s ${OBJ_PATH}/gcov-dump-${GCC_VERSION} ${LNK_PATH}/gcov-dump

sudo rm ${LNK_PATH}/gcov-tool
sudo ln -s ${OBJ_PATH}/gcov-tool-${GCC_VERSION} ${LNK_PATH}/gcov-tool

sudo rm ${LNK_PATH}/gfortran
sudo ln -s ${OBJ_PATH}/gfortran-${GCC_VERSION} ${LNK_PATH}/gfortran

sudo rm ${LNK_PATH}/lto-dump
sudo ln -s ${OBJ_PATH}/lto-dump-${GCC_VERSION} ${LNK_PATH}/lto-dump

sudo rm ${LNK_PATH}/x86_64-linux-gnu-c++
sudo ln -s ${OBJ_PATH}/x86_64-linux-gnu-c++-${GCC_VERSION} ${LNK_PATH}/x86_64-linux-gnu-c++

sudo rm ${LNK_PATH}/x86_64-linux-gnu-g++
sudo ln -s ${OBJ_PATH}/x86_64-linux-gnu-g++-${GCC_VERSION} ${LNK_PATH}/x86_64-linux-gnu-g++

sudo rm ${LNK_PATH}/x86_64-linux-gnu-gcc
sudo ln -s ${OBJ_PATH}/x86_64-linux-gnu-gcc-${GCC_VERSION} ${LNK_PATH}/x86_64-linux-gnu-gcc

sudo rm ${LNK_PATH}/x86_64-linux-gnu-gcc-ar
sudo ln -s ${OBJ_PATH}/x86_64-linux-gnu-gcc-ar-${GCC_VERSION} ${LNK_PATH}/x86_64-linux-gnu-gcc-ar

sudo rm ${LNK_PATH}/x86_64-linux-gnu-gcc-nm
sudo ln -s ${OBJ_PATH}/x86_64-linux-gnu-gcc-nm-${GCC_VERSION} ${LNK_PATH}/x86_64-linux-gnu-gcc-nm

sudo rm ${LNK_PATH}/x86_64-linux-gnu-gcc-ranlib
sudo ln -s ${OBJ_PATH}/x86_64-linux-gnu-gcc-ranlib-${GCC_VERSION} ${LNK_PATH}/x86_64-linux-gnu-gcc-ranlib

sudo rm ${LNK_PATH}/x86_64-linux-gnu-gfortran
sudo ln -s ${OBJ_PATH}/x86_64-linux-gnu-gfortran-${GCC_VERSION} ${LNK_PATH}/x86_64-linux-gnu-gfortran
