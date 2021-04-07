curl -L https://install.pivpn.io | bash
# Follow install, choose Wireguard VPN, Static IP Address, Local user, Port (default 51820 : change to 51330), DNS Cloudfare, Use default Public IP (Arnaud 86.215.12.125), enable unattend packages
# Add a user : pivpn -a 
# Enable or disable wg : wg-quick up/down INTERFACE
# conf is copied in /home/user/configs ; copy and transfer to define user


#### WIREGUARD

sudo wg-quick up wg1
sudo wg show
ssh gomonriou@10.6.0.1

#### SAMBA

sudo smbpasswd -a XXX mettre mfp user
sudo nano /etc/samba/smb.conf
sudo systemctl restart smbd

sudo mount -t cifs -o user=gomonriou,rw,uid=1000,gid=1000 //10.6.0.1/sharedwithsneaky /home/gomonriou/Documents/projet_b3/shared/sneaky
sudo mount -t cifs -o user=gomonriou,rw,uid=1000,gid=1000 //10.6.0.1/sharedhome /home/gomonriou/Documents/projet_b3/shared/home

le mdp est dans dashlane
pour la maison mettre l'adresse 192.168.1.100
