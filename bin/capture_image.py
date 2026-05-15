# !/usr/bin/env python3
# This script captures an image using the picamera2 library. It provides friendlier access to common parameters:
# alias for use in a filename using a standard format - optional, defaults to timestamped filename
# encoding as jpg/png/bmp/dng - defaults to jpg
# jpg quality defaults to 85
# resolution modes: sensor max, balanced, and fast presets
# raw image capture in addition to jpg, png or bmp
# aspect ratio for image with values in 4:3, 3:2 16:9, 1:1 - defaults to 4:3
# resolution of image with values in 1-8MP (any aspect ratio), or using the SD/HD/FHD/UHD presets (16:9 aspect ratio only) - defaults to 5MP (2560x1920); UHD is disabled until better sensors are available
# shutter speed for exposure control - defaults to auto
# auto white balance mode from the following options: off, auto, incandescent, tungsten, fluorescent, indoor, outdoor, cloudy
# timelapse settings for capturing multiple images at set intervals
# defaults to standard single image capture session using rpicam-still
# program mode for multiple shots, e.g. burst mode, with one-time auto 3A convergence metering:
## disposable camera session is run to obtain and lock exposure, white balance and gain settings
## exposure, white balance and/or gain can be manually set to override auto settings from disposable camera session
## capture session is run with immediate flag enabled, using stored settings from disposable camera session
# priority modes for exposure, white balance and gain allow individual manual input(s) to override auto settings
# manual mode for full control over exposure, white balance and gain settings
# timeout for delayed capture of image as a timer in seconds
# signal based capture upon enter key is disabled until the GUI is implemented
# nopreview of image is enabled until the GUI is implemented when it will be tied to signal based capture
# thumb resolution is standardized to 320x240

import picamera2
import time
import sys
import os
import signal 
import subprocess
import datetime
import logging
import get_filename from get_filename.py

get_filename
