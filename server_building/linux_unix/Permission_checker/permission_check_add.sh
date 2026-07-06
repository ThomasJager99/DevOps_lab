#!/bin/bash

set -e

cd /home/user/Your_dir

find . -type f -name "*.sh" -exec chmod 744 {} +
