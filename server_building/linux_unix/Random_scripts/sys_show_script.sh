#!/bin/bash
set -e

echo "Hello all!"

echo "Operating from: " $PWD

echo "Process from: "

#top -b -n1

ps -ef
echo "Date and time: " 
#date +%D
date | awk '{print $2, $3, $4}'

echo "errors" 
grep -rl "error" /var/log >> /opt/250425-ptm/Artem.Z/test2.txt
#2>/dev/null 


echo "Your OS: " 
cat /etc/os-release
echo "Number of lines in os-release: "
cat os-release | wc -l

echo "Last 5 lines of os-release: "
tail -n 5 /etc/os-release


echo "List of users: "
awk -F ':' '{print $1, $7}' /etc/passwd

echo "I got this"

