#!/bin/bash
# Daily backup w/ rotation of Samba server

BACKUP_FILES=/home/shared
BACKUP_DIR=/home/sneaky/backups
BACKUP_LIMIT=7
COUNT=`find $BACKUP_DIR -maxdepth 1 -type f -name "*.tar.gz" | wc -l`
DATE=`date +"%Y_%m_%d"`

# Compress files with tar, redirect STDERR to STDOUT to /dev/null
# c (create), p (preserve permissions), v (verbose), z (gzip), f (file)
mkdir -p $BACKUP_DIR
tar -czpf $BACKUP_DIR/shared_backups-$DATE.tar.gz $BACKUP_FILES > /dev/null 2>&1


if [[ $COUNT -gt $BACKUP_LIMIT ]]; then
	LAST=`find $BACKUP_DIR -maxdepth 1 -type f -name "*.tar.gz" | awk "NR>7"`
	rm $LAST
fi

ls -lhtp $BACKUP_DIR
echo "Number of backups=$COUNT"
