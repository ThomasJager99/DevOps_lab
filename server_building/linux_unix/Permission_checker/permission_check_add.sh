#!/bin/bash

set -e

cd /home/user/Your_dir

for NAMES in $(find . -type f -name "*.sh")
do 
chmod 744 "$NAMES" 
done
