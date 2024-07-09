#!/bin/bash

set -e  # Exit immediately on error

highest_number=-1
# shellcheck disable=SC2034
latest=""

# Find the highest numbered file in src folder
for file in src/*.cpp; do
    if [[ $(basename "$file") =~ ([0-9]+) ]]; then
        number=${BASH_REMATCH[1]}
        # shellcheck disable=SC2001
        number=$(echo "$number" | sed 's/^0*//')
        if (( number > highest_number )); then
            highest_number=$number
        fi
    fi
done

if (( highest_number != -1 )); then
    echo "Latest file number: $highest_number"

    # Check if build folder exists
    if [ ! -d build ]; then
        echo "Build folder not found. Building..."
        ./scripts/build.sh
    else
        # Find the latest build file in build folder
        # shellcheck disable=SC2010
        latest_build=$(ls build | grep "$highest_number")

        if [[ -n $latest_build ]]; then
            echo "Latest build found: $latest_build"

            # Create latest version of ppm
            ./build/"$latest_build" > "dist/$(basename "$latest_build").ppm"
            echo "Created dist/$(basename "$latest_build").ppm"

            # Convert ppm to png
            mkdir -p images  # Create images directory if not exists
            echo "Converting ppm to png..."
            ./ppm2png/build/ppm_to_png "dist/$(basename "$latest_build").ppm" "images/$(basename "$latest_build").png"
            echo "Converted dist/$(basename "$latest_build").ppm to images/$(basename "$latest_build").png"

            ./scripts/get_latest_image.sh
        else
            echo "No build found with the latest number."
        fi
    fi
else
    echo "No files found with a number in the filename."
fi
