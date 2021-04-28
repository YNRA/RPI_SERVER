# Wireguard installation et configuration

```bash
curl -L https://install.pivpn.io | bash
```

Ce script bash installera PiVPn sur la machine. A partir de là, il est possible d'utiliser `pivpn`et ses arguments pour ajouter des fichiers de configurations, utilisateurs etc. Il est également possible de le faire manuellement, ce que nous avons préféré dans un second temps.

```bash
sudo apt-get install wireguard
# Configuration du serveur Wireguard
sudo vim /etc/wireguard/wg0.conf
    [Interface]
    Address = 10.6.0.2/29
    ListenPort = 51330
    PrivateKey = XXXXXXXX
    ### begin Gomonriou RPI ###
    [Peer]
    PublicKey = XXXXXXXX
    AllowedIPs = 10.6.0.1/32
    Endpoint = 90.120.XXX.XXX:51330
    ### end Gomonriou ###
    ### begin Gomonriou LINUX ###
    [Peer]
    PublicKey = XXXXXXXX
    AllowedIPs = 10.6.0.4/32
    ### end Gomonriou ###
    ### begin Sneaky MAC ###
    [Peer]
    PublicKey = XXXXXXXX
    AllowedIPs = 10.6.0.5/32
    ### end Sneaky ###
    ### begin Gomonriou ANDROID ###
    [Peer]
    PublicKey = XXXXXXXX
    AllowedIPs = 10.6.0.6/32
    ### end Gomonriou ###
    
 sudo wg-quick up wg0
 sudo systemctl enable wg-quick@wg0
 
 # Activer ou désactiver l'interface 
 sudo wg-quick up wg0
 sudo wg-quick down wg0

# Génération de clé privée et publique pour un utilisateur
sudo su
cd /etc/wireguard
umask 077
wg genkey | tee privatekey | wg pubkey > publickey

# Exemple de fichier de configuration pour un client
  [Interface]
  PrivateKey = XXXXXXXX
  Address = 10.6.0.5/29
  DNS = 9.9.9.9, 149.112.112.112

  [Peer]
  PublicKey = XXXXXXX
  AllowedIPs = 10.6.0.2/32
  Endpoint = 86.215.XXX.XXX:51330

  [Peer]
  PublicKey = XXXX
  AllowedIPs = 10.6.0.1/32
  Endpoint = 90.120.XXX.XXX:51330
```



Afin de rendre le VPN accessible à nos hôtes distants, il convient d'exposer le port 51330 en NAT sur le routeur de nos domiciles.