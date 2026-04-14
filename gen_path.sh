#!/bin/bash
# gen_path.sh
# Usage: ./gen_path.sh extension prefix [--stdpath|--dir|--stdname|--filename|--filepath] filename
# Examples:
#   ./gen_path.sh dng - stdpath timestamped dng path
#   ./gen_path.sh jpg highres --dir - get directory for highres jpg
#   ./gen_path.sh jpg preview 625 - get filepath of a preview jpg with custom filename 625
#   ./gen_path.sh dng capture --fid 777 - get filename of a capture dng with custom filename 777

# Valid values for extension, filename prefix, and mode
valid_exts=("jpg" "png" "dng" "raw")
valid_prefixes=("capture" "preview" "highres" "lowres" "fullres")
valid_modes=("--stdpath" "--directory" "--stdname" "--filename" "--filepath")

# Get current timestamp in YYYYMMDD_HHMMSS format
get_timestamp () {
 local timestamp=$(date +"%Y%m%d_%H%M%S")
 echo "$timestamp"
}

# Generate default standardized filename
get_stdname() {
  local stdname="${ext}_${prefix}_$(get_timestamp).${ext}"
  echo "$stdname"
}

# Check if output directory exists, create if not
get_outdir() {
  local outdir="$HOME/raspycam/${ext}_${prefix}_images"
  if [ ! -d "$outdir" ]; then 
    mkdir -p "$outdir"
  fi
  echo "$outdir"
}

# Normalize mode aliases
normalize_mode() {
  case "$1" in
    -s|--sp|--std|--stdpath) echo "--stdpath" ;;
    -d|--d|--dir|--directory) echo "--directory" ;;
    -sn|--stdname) echo "--stdname" ;;
    --fid|--filename) echo "--filename" ;;
    -f|--fp|--filepath) echo "--filepath" ;;
    *) echo "$1" ;; # leave unchanged
  esac
}

# Parse arguments for extension and filename prefix
ext="$1"
prefix="${2:-capture}"

# Validate presence and value of extension
if [ -z "$ext" ]; then
  echo "Error: missing extension. Allowed: ${valid_exts[*]}" >&2
  exit 1
elif [[ ! " ${valid_exts[@]} " =~ " ${ext} " ]]; then
  echo "Error: invalid extension '$ext'. Allowed: ${valid_exts[*]}" >&2
  exit 1
fi

# Validate filename prefix
if [[ ! " ${valid_prefixes[@]} " =~ " ${prefix} " ]]; then
  echo "Error: invalid prefix '$prefix'. Allowed: ${valid_prefixes[*]}" >&2
  exit 1
fi

# Default mode is stdpath and filename is empty
mode="--stdpath"
filename=""

# Auto-detect input as mode vs custom filename
if [[ -n "$3" ]]; then
  if [[ "$3" == -* ]]; then
    # Input $3 is a flag - normalize it as a mode flag
    mode=$(normalize_mode "$3")
    if [[ -n "$4" ]]; then
      # Input $4 provides custom filename
      filename="${ext}_${prefix}_$4.${ext}"
    else
      # No custom filename provided - use standard default
      filename=$(get_stdname)
    fi
  else
    # $3 is not a flag - treat as custom filename
    mode="--filepath"
    filename="${ext}_${prefix}_$3.${ext}"
  fi
fi

# Validate mode flag
if [[ ! " ${valid_modes[@]} " =~ " ${mode} " ]]; then
  echo "Error: invalid mode '$mode'. Allowed: ${valid_modes[*]}" >&2
  exit 1 
fi

# Generate and return output based on mode
case "$mode" in
  --stdname)
    # Standardized name with timestamp
    stdname=$(get_stdname)
    echo "$stdname"
    ;;
  --directory)
    # Directory only
    outdir=$(get_outdir)
    echo "$outdir"
    ;;
  --stdpath)
    # Standardized full path with timestamp
    stdname=$(get_stdname)
    outdir=$(get_outdir)
    stdpath="${outdir}/${stdname}"
    echo "$stdpath"
    ;;
  --filename)
    # Custom filename only, already constructed
    echo "$filename"
    ;;
  --filepath)
    # Full filepath with custom filename
    outdir=$(get_outdir)
    filepath="${outdir}/${filename}"
    echo "$filepath"
    ;;
  *)
    # Default to standardized full path with timestamp
    stdname=$(get_stdname)
    outdir=$(get_outdir)
    stdpath="${outdir}/${stdname}"
    echo "$stdpath"
    ;;
esac
