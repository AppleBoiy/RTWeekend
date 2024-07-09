#!/usr/bin/env bash


[ ! -d build ] && mkdir build
cd build || exit 1
cmake .. || exit 1
make || exit 1
cd ..

[ ! -d dist ] && mkdir dist
