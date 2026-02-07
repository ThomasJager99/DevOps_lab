#!/bin/bash

set -e

FROMDIR="/opt/250425-ptm/Artem.Z/Fold1"
TODIR="/opt/250425-ptm/Artem.Z/Fold2/"
#A=$(ls "$FROMDIR")
#cd "$FROMDIR"

for file in "$FROMDIR"/*; do
    name=$(basename "$file")
    if (( name % 2 == 0 )); then
        mv "$file" "$TODIR"
    fi
done
