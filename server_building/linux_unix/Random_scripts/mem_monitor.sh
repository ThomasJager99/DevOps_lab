#!/bin/bash

#set -e

#Set the threshold for used disk space (in percent)

threshold=70

#find / -type f -name '*.*' -size +1M -exec du -h {} + 2>/dev/null


#Get the used disk space

disk_usage=$( df -h / | awk 'NR==2 {print $5}' | sed 's&%&&')

	if [ $disk_usage -gt $threshold ]; then
	echo -e "WARNING $threshold% \n searching largest dir and files"
	echo "Largest dir and files:"
#Find and display the top 10 largest DIR and files
	sudo du -ah / | sort -r | head -10 2>/dev/null
	else 
	echo "Disk space in root: =< $threshold%"
	fi


