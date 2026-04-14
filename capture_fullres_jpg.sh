#!/bin/bash
# capture_jpg_full.sh
# capture a full-resolution JPEG image
# Usage: ./capture_jpg_full.sh

# Get all path info from helper
filepath=$(./gen_path.sh jpg fullres)

# Run rpicam-still with desired options
rpicam-still \
  -n \
  --encoding jpg \
  --output "$filepath" \

echo "Saved $filepath"