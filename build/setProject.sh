#! /usr/bin/env bash 

rm CMakeCache.txt
cmake .. -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Debug

