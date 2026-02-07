



















[ec2-user@ip-10-0-42-153 Artem.Z]$ clear

[ec2-user@ip-10-0-42-153 Artem.Z]$ crontab -e
crontab: installing new crontab
[ec2-user@ip-10-0-42-153 Artem.Z]$ nano task_ARTEM.sh 



















  GNU nano 2.9.8                 task_ARTEM.sh                           

#!/bin/bash

#set -e

DATE=$(date +"%d_%m_%Y")
ARCH_PATH="/opt/250425-ptm/Artem.Z/Art_arch"
FOLDS_PATH="/opt/250425-ptm/Artem.Z/all_folds"

mkdir -p /opt/250425-ptm/Artem.Z/Art_arch
mkdir -p /opt/250425-ptm/Artem.Z/all_folds

        for n in {1..10}; do
        mkdir -p "$FOLDS_PATH"/"$n"_"$DATE"
        done

history | tail -50 > "$FOLDS_PATH"/my_history.txt 

tar -czf "$ARCH_PATH"/archive.tar.gz "$FOLDS_PATH"

