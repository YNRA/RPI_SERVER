# Samba configuration et installation

Nous avons choisi Samba pour le partage de fichiers. Le samba est présent sur un des deux RPi, et l'autre RPi doit simplement monter le dossier pour y accéder.

```bash
sudo apt-get install samba samba-common-bin

# Configuration
sudo vim /etc/samba/smb.conf

   [global]
   # Création des logs
   log file = /var/log/samba/global.log
   log level = 1 vfs:10
   vfs objects = full_audit
   full_audit:prefix = %u|%U|%I|%m|%S|%T|%D
   full_audit:success = mkdir rename unlink rmdir pwrite
   full_audit:failure = connect
   full_audit:facility = local1
   full_audit:priority = NOTICE INFO

  [sharedwithsneaky]
  # Création du dossier partagé avec l'autre RPi
  path = /home/shared/shared_sneaky
  writeable = yes
  public=no
  read only = no
  browseable = yes
  write list = work
  force directory mode = 0777

  [sharedhome]
  # Création du dossier partagé pour le domicile
  path = /home/shared/shared_home
  writeable = yes
  public=no
  read only = no
  browseable = yes
  write list = home
  force directory mode = 0777
  
# Création des utilisateurs
sudo adduser XXXX
sudo smbpasswd -a XXX
sudo systemctl restart smbd

# Monter le dossier sur l'autre RPi
sudo mount -t cifs -o user=XXXX,rw,uid=1000,gid=1000 //10.6.0.1/sharedwithsneaky /path
```
