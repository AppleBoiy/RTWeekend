#!/bin/bash

highest_number=-1
latest_image=""

# Loop through all files in images directory
for file in images/*; do
    # Extract the number from the file name
    if [[ $(basename "$file") =~ ([0-9]+) ]]; then
        number="${BASH_REMATCH[1]}"
        # shellcheck disable=SC2001
        number=$(echo "$number" | sed 's/^0*//')

        # Check if this number is the highest so far
        if (( number > highest_number )); then
            highest_number="$number"
            latest_image="$file"
        fi
    fi
done

# Check if a latest image was found
if [[ -n $latest_image ]]; then
    # Copy the latest image to the same folder with the new name
    cp "$latest_image" "images/00_Latest.png"
    echo "Copied $latest_image to images/00_Latest.png"
else
    echo "No images found with a number in the filename."
fi
