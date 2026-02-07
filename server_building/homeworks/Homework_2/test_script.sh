#!/bin/bash

set -e

#Create variables for path

PATHARCH="/tmp/Artem.z/Archive/"

EXTPATH="/tmp/Artem.z/Extpath/"

TIME=$(date +%T)

DATE=$(date +%d-%m-%y)

DIR="/home/Artem.z/from1_5"

#Create nassesary directorys

mkdir -p "$PATHARCH" "$EXTPATH"

#First we make 5 dir with name Dir1..5
	for D in {1..5}; do
	mkdir -p "$DIR/Dir$D"
	done

#Then we create 5 Files and ask this cicle to look inside 
#each one dir and see if file exists/if not - create File1..5/txt
	for F in {1..5}; do
	date +%T > "$DIR/Dir$F/File-$F.txt" 
	sleep 5
	done

#Show us what was created

ls "$DIR"

#Now out all what created inside one archive 

tar -czvf "$PATHARCH/$DATE".tar.gz "$DIR" 

#Then unzip this archive to particular path

tar -xzf "$PATHARCH/$DATE".tar.gz -C "$EXTPATH"

#

