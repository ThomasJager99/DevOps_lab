#!/bin/bash



set -e



cd /opt/250425-ptm/



for NAMES in $(find . -type f -name "*.sh")

do 

chmod 744 "$NAMES" 

done
