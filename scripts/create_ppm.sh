#!/usr/bin/env bash

# check build folder if not run build.sh
if [ ! -d build ]; then
    echo "ppm2png is not built. Building ppm2png..."
    ./scripts/build.sh || exit 1
fi

# list executable files
echo "Creating ppm files..."
ls_binaries () {
  [ ! -d dist ] && mkdir dist
  for file in build/*; do
    # ignore CMake files
    if [[ "$file" == *"CMakeFiles"* ]]; then
      continue
    fi
    if [ -x "$file" ]; then
      ./"$file" > "dist/$(basename "$file").ppm"
    fi
  done
}
ls_binaries || { echo "No executable files found in build folder."; exit 1;}

echo "ppm files created in dist folder."