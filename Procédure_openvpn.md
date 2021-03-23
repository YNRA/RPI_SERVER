https://www.digitalocean.com/community/tutorials/how-to-set-up-and-configure-an-openvpn-server-on-ubuntu-20-04-fr

sudo apt update
sudo apt install openvpn easy-rsa
mkdir ~/easy-rsa
ln -s /usr/share/easy-rsa/* ~/easy-rsa/
sudo chown $USER ~/easy-rsa 
chmod 700 ~/easy-rsa
cd ~/easy-rsa
touch vars
echo 'set_var EASYRSA_ALGO "ec"' >> vars
echo 'set_var EASYRSA_DIGEST "sha512"' >> vars
./easyrsa init-pki
cd ~/easy-rsa
./easyrsa gen-req server nopass
sudo cp /home/$USER/easy-rsa/pki/private/server.key /etc/openvpn/server/

ETAPE 4

cd ~/easy-rsa
openvpn --genkey --secret ta.key
sudo cp ta.key /etc/openvpn/server

mkdir -p ~/client-configs/keys
chmod -R 700 ~/client-configs
cd ~/easy-rsa
./easyrsa gen-req client1 nopass
cp pki/private/client1.key ~/client-configs/keys/

<!-- scp pki/reqs/client1.req sammy@your_ca_server_ip:/tmp etape 6 arrété ici -->