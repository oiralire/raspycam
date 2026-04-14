#!/bin/bash
# capture_jpg_low.sh
# capture a low resolution JPEG image
# Usage: ./capture_jpg_low.sh

# Get all path info from helper
filepath=$(./gen_path.sh jpg lowres)

# Run rpicam-still with desired options
rpicam-still \
  -n \
  --encoding jpg \
  --output "$filepath" \
  --width 640 \
  --height 480

echo "Saved $filepath"