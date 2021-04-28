# Script de backup

Pour mettre en place un système de backup automatisé, nous avons choisi d'écrire un script bash plutôt simpliste, qui compresse le dossier voulu avec `tar`tous les jours via les tâches cron.

Le dossier `shared`est le dossier de partage de fichiers de Samba. Pour fonctionner, le dossier doit être monté et crée. Ce dossier est accessible par nos deux comptes utilisateurs.

```bash
sudo mkdir -p /home/shared
sudo groupadd shared
sudo chgrp -R shared /home/shared
sudo chmod -R 2777 /home/shared
sudo usermod -aG shared sneaky
sudo usermod -aG shared gomonriou
```



```bash
#!/bin/bash
# Daily backup w/ rotation of Samba server

USER=USERNAME # Replace w/ username. Otherwise, it will be in /root
BACKUP_FILES=/home/shared
BACKUP_DIR=/home/$USER/backups
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
```



