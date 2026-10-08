#!/bin/bash
# Runs in both the pwnmake image (which executes garble to produce the *.grb
# files) and the pwncc image (which compiles/links garble).
apt-get update
apt-get install -y --no-install-recommends libpng-dev
