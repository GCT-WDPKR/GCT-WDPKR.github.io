#!/bin/bash

# Define the path to the cwebp executable
CWEBP_PATH="../libwebp-1.4.0-windows-x64/bin/cwebp.exe"

# Define the quality level
QUALITY=80

# Check if a directory was provided as an argument
if [ -z "$1" ]; then
  echo "Usage: $0 <directory>"
  exit 1
fi

# Assign the directory to a variable
DIR="$1"

echo "Converting files in $DIR"

# Find all .png and .jpg files in the directory and its subdirectories
find "$DIR" -type f \( -iname "*.png" -o -iname "*.jpg" \) | while read -r FILE; do
  # Get the file extension
  EXT="${FILE##*.}"
  # Create the output filename by replacing the extension with .webp
  OUTPUT="${FILE%.*}.webp"
  
  # Run the cwebp command
  "$CWEBP_PATH" -q $QUALITY "$FILE" -o "$OUTPUT"
  
  # Check if the command was successful
  if [ $? -eq 0 ]; then
    echo "Converted $FILE to $OUTPUT"
  else
    echo "Failed to convert $FILE"
  fi
done
