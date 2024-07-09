#!/usr/bin/env bash

# check if ppm2png is installed (ppm2png folder is not empty)
if [ ! "$(ls -A ppm2png)" ]; then
    echo "ppm2png is not installed. Please install it first."
    exit 1
fi
# check build folder if not run build.sh
if [ ! -d ppm2png/build ]; then
    echo "ppm2png is not built. Building ppm2png..."
    cd ppm2png || exit 1
    ./build.sh || exit 1
    cd ..
fi

# run build script
./scripts/build.sh

# convert ppm to png
[ ! -d images ] && mkdir images
echo "Converting ppm to png..."
convert_ppm () {
  for file in dist/*.ppm; do
    ./ppm2png/build/ppm_to_png "$file" "images/$(basename "$file" .ppm).png"
  done
}
convert_ppm || { echo "No ppm files found in dist folder."; exit 1;}