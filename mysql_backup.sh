#!/bin/bash

#Clear the terminal so our input can be easily read
clear

#Declare the backup directory
BACKUP_DIR="${HOME}/Backup/mysql"

#Declare the backup filename based on the current time
BACKUP_FILENAME=$(date "+%H-%M-%S-%d-%b-%C")

#Put the two together
BACKUP_FULL_PATH="${BACKUP_DIR}/${BACKUP_FILENAME}.sql"

#Check if our backup file exsists
if [ ! -d "$BACKUP_DIR" ]; then

	#Create the backup folder
	echo "Creating backup directory at ${BACKUP_DIR}"
	mkdir --parents "$BACKUP_DIR"

else
	echo "Using backup directory ${BACKUP_DIR}"
fi

#Wait a second before output next command
sleep 1

#Dump all the databases into our backup file
echo "Backuping up databases into ${BACKUP_FULL_PATH}"
mysqldump -uroot -p --all-databases > "${BACKUP_FULL_PATH}"


#Tar up the files for space reasons
echo "Compressing backup"
tar -cz -f "${BACKUP_FULL_PATH}.tgz" -C ${BACKUP_DIR} "${BACKUP_FILENAME}.sql"

#Delete the uncompressed file
echo "Cleaning up"
rm $BACKUP_FULL_PATH
