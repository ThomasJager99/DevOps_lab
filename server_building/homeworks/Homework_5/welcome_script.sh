#!/bin/bash



set -e



echo "Current date: $(date)"



echo "Hello," $USER



echo "Operating from directory: $(pwd)"



echo -n "Number of bioset processes: "

ps -f | grep bioset | grep -v grep | wc -l



echo -n "Permission for /etc/passwd: "

ls -l /etc/passwd | awk '{print $1}'
