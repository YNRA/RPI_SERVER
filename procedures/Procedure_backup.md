# CRON TASK
0 18	* * * sudo tar -cvpzf /home/sneaky/shared_backup/shared_backup_`date +"\%Y-\%m-\%d"`.tar.gz /home/shared/ 

# LOGROTATE

> /etc/logrotate.d/shared_backups 

/home/sneaky/shared_backup/*.tar.gz {
	daily
	missingok
	rotate 5
	notifempty
}
