#!/bin/bash



set -e

cd /opt/250425-ptm/

find . -type f -name "*.sh" -exec chmod 744 {} +
