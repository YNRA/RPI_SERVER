# Installation et configuration basique

Une fois l'OS voulue flashée sur la carte (Raspbian / Debian de préférence), on allume le Raspberry Pi. Pour la première utilisation, il est nécessaire de disposer d'un clavier et d'un écran, le SSH n'étant pas activé. 

A NOTER : Raspian dispose de `raspi-config`qui offre une petite interface graphique permettant aisément de changer un mot de passe, d'activer différents services, de connecter un réseau etc. Nous avons préféré les commandes manuelles et ne pas se servir de cet utilitaire. 

Sur Raspbian, l'utilisateur de connexion par défaut est "pi". Sur Debian, on peut utiliser root. Après la connexion, il convient donc par mesure de sécurité de supprimer l'utilisateur "pi", et d'en créer un autre:

```bash
# Avec l'utilisateur pi [RASPBIAN]
sudo adduser USER
sudo usermod -a -G sudo USER
su USER
sudo pkill -u pi
sudo deluser pi
sudo deluser -remove-home pi

# Avec l'utilisateur root [DEBIAN]
passwd
```

On peut commencer la configuration :

```bash
sudo apt-get update -y && sudo apt-get upgrade
# Outils de réseau et serveur ssh
sudo apt-get install net-tools openssh-server
# Configuration de l'interface réseau
vim /etc/network/interfaces.d/wlan0 #[DEBIAN]
vim /etc/wpa_supplicant/wpa_supplicant.conf #[RASPBIAN]
  network={
    ssid="ssid_du_reseau"
    psk="password"
    id_str="monreseau"
  }
sudo systemctl restart networking.service

# Fixer l'adresse IP en statique pour une question de pratique sur notre réseau local, pas de DHCP
# [RASPBIAN]

vim /etc/dhcp.conf
  interface wlan0
  static ip_address=192.168.1.99/24
  static routers=192.168.1.1
  static domain_name_servers=192.168.1.1 1.1.1.1 8.8.4.4

# [DEBIAN]
vim /etc/network/interfaces.d/wlan0

iface enp0s3 inet static
  address 192.168.1.99
  netmask 255.255.255.0
  network 192.168.1.1
  broadcast 192.168.1.255
  gateway 192.168.1.1

# On peut également rajouter des DNS manuellement dans /etc/resolv.conf
# Désactivation de l'IPV6
vim /etc/sysctl.conf

  net.ipv6.conf.all.disable_ipv6 = 1
  net.ipv6.conf.all.autoconf = 0
  net.ipv6.conf.default.disable_ipv6 = 1
  net.ipv6.conf.default.autoconf = 0

# Configuration du SSH
sudo systemctl enable ssh
ssh-keygen -t rsa -b 4096
ssh-copy-id -i ~/.ssh/id_rsa.pub
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
vim /etc/ssh/sshd_config

  PermitRootLogin no
  PubkeyAuthentification yes
  PasswordAuthentification no
  StrictModes yes
  Protocol 2
  PermitEmptyPasswords no
  AuthorizedKeysFile .ssh/authorized_keys

sudo systemctl start ssh

```

