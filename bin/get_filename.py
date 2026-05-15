# !/usr/bin/env python3
# This script generates a filename based on provided filetype and optional alias. If no alias is provided, a standard timestamped filename is generated.

function get_filename(filetype, alias):

    # Step 1: validate filetype
    allowed = ["jpg", "png", "bmp", "dng"]
    if filetype not in allowed:
        raise error "Unsupported filetype"

    # Step 2: validate alias
    if alias contains characters outside [A-Za-z0-9_-]:
        raise error "Invalid alias. Use only letters, numbers, underscores, or hyphens."

    # MAY OMIT THIS STEP IF DIRECTORY HANDLING IS MANAGED IN CAPTURE_IMAGE.PY
    # Step 3: ensure ./images exists 
    if ./images does not exist:
        create ./images

    # Step 4: Build filename
    - get current date as YYYYMMDD
    - get current hours as HH
    - get current minutes as MM 
    - get current seconds as SS
    - if alias is provided and filename already exists in ./images:
        filename = "img_" + alias + "_" + date + "_" + hours + minutes + seconds + "." + filetype
    - if alias is provided and filename does not exist in ./images:
        filename = "img_" + alias + "_" + date + "_" + hours + minutes + "." + filetype
    - else:
        filename = "img_" + filetype + "_" + date + "_" + hours + minutes + seconds + "." + filetype
    # Step 5: return full path
    return "./images/" + filename
