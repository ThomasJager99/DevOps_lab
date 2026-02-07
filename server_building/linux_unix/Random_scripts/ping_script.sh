#!/bin/bash

#set -e 

       	while true; do 
        PING=$(ping -c 10 8.8.8.8)
        #TIME=$(echo "$PING" | awk '/time=/{print $8}' | cut -d '=' -f 2)
        #TIME=$(echo "$PING" | awk '/time /{print $10}' | cut -d 'm' -f 1)
        TIME=$(echo "$PING" | awk '/rtt/ {print $4}' | cut -d '/' -f 2)
        RECEIV=$(echo "$PING" | awk '/packets received/{print $4}')
		#In Linux its just received / in MacOS its packets received
		if (( $(echo "$TIME > 100" | bc -l) )); then
                echo "Connection time more then: 100ms" 
                break
                elif [ "$RECEIV" -lt 1 ]; then 
                echo "Cannot reach the server"
                break 
                fi
        sleep 1
        done



