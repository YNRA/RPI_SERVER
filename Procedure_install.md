- connection root nopasswd
- changer mdp passwd
- changer clavier install les packets + dpkg-reconfigure locales
- activer wifi nano /etc/network/interfaces.d/wlan0 mettre ssid et le mdp puis reboot
- fixer l'addresse ip

- desactiver ipv6 dans /etc/sysctl.conf
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.all.autoconf = 0
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.default.autoconf = 0

- nouvel utilisateur dans sudoers
adduser XXXX
apt-get install sudo
usermod -aG sudo XXXX
su - gomonriou
whoami
sudo - XXXX
sudo whoami

-ssh
1. ssh-keygen -t rsa -b 4096
2. ssh-copy-id -i ~/.ssh/id_rsa.pub (autre methode en annexe)
3. /etc/ssh/sshd_config :
   * PermitRootLogin no
   * PubkeyAuthentication yes
   * PasswordAuthentication no
   * StrictModes yes
   * Protocol 2

chmod go-w ~/
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys