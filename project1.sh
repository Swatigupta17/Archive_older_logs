#!/bin/bash

<<comment
Archive older files or larger files

Steps:
1) Provide path of Directory
2) Check if directory is present or not
3) Create archive folder if not present
4) Find all files with size more than 20kb
5) Compress each file
7) Make a cron job to run everyday at given time
comment

#declare variables

path=/home/vboxuser
days=10
depth=1
run=0

#check if directory is present or not

if [[ ! -d $path ]]
then
	echo "Given directory is not present"
	exit 1
fi

# check if archive folder is present or not, if not preset create it

if [[ ! -d $path/archive ]]
then
	mkdir $path/archive
fi

#find all the files greater than 2 kb and older than 10 days


for i in `find $path -maxdepth $depth -type f -size +2k`
do
	if [[ $run -eq 0 ]]
	then
		gzip $i || exit 1
		mv $i.gz $path/archive || exit 1
	fi
done




