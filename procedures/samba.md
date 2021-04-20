sudo apt-get install samba samba-common-bin


sudo nano /etc/samba/smb.conf

[dans_global]

   log file = /var/log/samba/global.log

   log level = 1 vfs:10
   vfs objects = full_audit

   full_audit:prefix = %u|%U|%I|%m|%S|%T|%D
   full_audit:success = mkdir rename unlink rmdir pwrite
   full_audit:failure = connect
   full_audit:facility = local1
   full_audit:priority = NOTICE INFO

[sharedwithsneaky]

path = /home/shared/shared_sneaky
writeable = yes
public=no
read only = no
browseable = yes
write list = work
force directory mode = 0777

[sharedhome]

path = /home/shared/shared_home
writeable = yes
public=no
read only = no
browseable = yes
write list = home
force directory mode = 0777

 1414  sudo adduser charline
 1415  cat /etc/group
 1416  sudo smbpasswd -a charline
 sudo systemctl restart smbd

dans -> etc/rsyslog.conf

local1.*        /var/log/samba/log.audit
les log de rsyslog (var/log/syslog) marqué local1 sont redirigé dans /var/log/samba/log.audit
/etc/init.d/rsyslog restart















#### SAMBA

sudo smbpasswd -a XXX mettre mfp user
sudo nano /etc/samba/smb.conf
sudo systemctl restart smbd

sudo mount -t cifs -o user=gomonriou,rw,uid=1000,gid=1000 //10.6.0.1/sharedwithsneaky /home/gomonriou/Documents/projet_b3/shared/sneaky
sudo mount -t cifs -o user=gomonriou,rw,uid=1000,gid=1000 //10.6.0.1/sharedhome /home/gomonriou/Documents/projet_b3/shared/home

le mdp est dans dashlane
pour la maison mettre l'adresse 192.168.1.100






sudo cat /var/log/syslog | grep smb