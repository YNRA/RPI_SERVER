# Installer samba
sudo apt-get install samba samba-common-bin

# Modifier la configuration
sudo nano /etc/samba/smb.conf

[dans_global]

   <!-- création des logs -->
   log file = /var/log/samba/global.log

   log level = 1 vfs:10
   vfs objects = full_audit

   full_audit:prefix = %u|%U|%I|%m|%S|%T|%D
   full_audit:success = mkdir rename unlink rmdir pwrite
   full_audit:failure = connect
   full_audit:facility = local1
   full_audit:priority = NOTICE INFO

   <!-- local1.*        /var/log/samba/log.audit
   les log de rsyslog (var/log/syslog) marqué local1 sont redirigé dans /var/log/samba/log.audit
   /etc/init.d/rsyslog restart -->

[sharedwithsneaky]

   <!-- création du dossié de partage avec Arnaud -->
path = /home/shared/shared_sneaky
writeable = yes
public=no
read only = no
browseable = yes
write list = work
force directory mode = 0777

[sharedhome]

   <!-- création du dossié de partage pour la maison -->
path = /home/shared/shared_home
writeable = yes
public=no
read only = no
browseable = yes
write list = home
force directory mode = 0777


# Créer les utilisateurs samba
sudo adduser XXX
sudo smbpasswd -a XXX
sudo systemctl restart smbd

# Pour monter le dossié
sudo mount -t cifs -o user=XXXX,rw,uid=1000,gid=1000 //10.6.0.1/sharedwithsneaky /path


