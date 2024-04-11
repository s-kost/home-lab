#!/bin/bash

# Colour Coding
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

# Handling the archive name
FILE_NAME="$(date +'%Y-%m-%d')-archive.tar.gz"

# Variables necessary for path specifications
BACKUP_FOLDER="/path/to/backup/folder"
USERNAME="<your username>"
SOURCE="/path/to/dirs/for/backup"

# These variable will store the amount of archives in the $BACKUP_FOLDER and reference the top file
FILES=$(find $BACKUP_FOLDER -type f | wc -l)
TOP_FILE=$(find $BACKUP_FOLDER -type f | head -n 1)

# This part of the script will check if there's more that 3 archives in the $BACKUP_FOLDER and delete the oldest one
while [ $FILES -ge 3 ]
do
    echo -e "${RED}Deleting the oldest archive....${NC}"
    sudo rm -rf $TOP_FILE

    # Updating the values of the variables
    FILES=$(find $BACKUP_FOLDER -type f | wc -l)
    TOP_FILE=$(find $BACKUP_FOLDER -type f | head -n 1)
done

# Going to the home directory and creating the new archive
echo -e "${GREEN}Creating a new archive....${NC}"
cd /home/$USERNAME
sudo tar -czf "$BACKUP_FOLDER/$FILE_NAME" $SOURCE
echo -e "${GREEN}Operation completed!!${NC}"