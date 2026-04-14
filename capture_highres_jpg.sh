#!/bin/bash
# capture_jpg_high.sh
# capture a high-resolution JPEG image
# Usage: ./capture_jpg_high.sh

# Get all path info from helper
filepath=$(./gen_path.sh jpg highres)

# Run rpicam-still with desired options
rpicam-still \
  -n \
  --encoding jpg \
  --output "$filepath" \
  --width 1920 \
  --height 1080

echo "Saved $filepath"