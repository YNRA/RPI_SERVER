- connection root nopasswd
- changer mdp passwd
- changer clavier install les packets + dpkg-reconfigure locales
- activer wifi nano /etc/network/interfaces.d/wlan0 mettre ssid et le mdp puis reboot
- fixer l'addresse ip
/etc/network/interfaces.d/wlan0
iface enp0s3 inet static
    address 192.168.1.99
    netmask 255.255.255.0
    network 192.168.1.1
    broadcast 192.168.1.255
    gateway 192.168.1.1
pareil mais /etc/network/interfaces.d/eth0 pour l'ethernet

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

- ohmyzsh
apt update && apt install fonts-powerline git curl zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

- wpa-supplicant (Debian)
/etc/wpa-supplicant

network={
	ssid="ssid_du_reseau"
	psk="password"
	id_str="monreseau"
}

apt-install wicd-curses for easy network management
