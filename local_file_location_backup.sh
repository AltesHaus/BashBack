#!/bin/bash
read -p "Do you want to save a snapshot of your current directory? (y/n) " agree

execution_datetime=$(date +"%Y%m%d_%H%M")

if [ $agree == "y" ]
then
    if [ -d "snapshot" ]
    then 
        echo "Snapshot folder found successfully."
    else
        mkdir snapshot
        echo "Your snapshot folder has been created."
    fi
    filename="./snapshot/content_$execution_datetime.txt"
    ls -l > "$filename"
    echo "snapshot saved to $filename"
else
    echo "You have decided to disagree. Have a nice day!"
fi

exit 0