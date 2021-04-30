# Installer le service TOR
        apt-get install tor

# Créer le dossier du service web
        mkdir /var/www/darkserver
        touch /var/www/darkserver/index.html

# Serveurs web - Clear & DeepWeb

Nous avons mis en place deux serveurs web distincts, un Apache présent sur le clear web, et un TOR hidden service, sur le Deep. 

## Apache

Le serveur web apache est relativement simple à mettre en place, étant donné que nous n'avons pas mis en place de site web réel, il n'y a que peu de commandes. Par ailleurs, il n'est pas exposé sur Internet, mais uniquement sur le VPN pour le moment, et il ne dispose que de peu de sécurité. Le site est une fausse page.

```bash
sudo apt-get install apache2
curl -O https://cdpn.io/chasekaiser/fullpage/ogXmOK
mv ogXmOK /var/www/html/index.html
```

## TOR

```bash
sudo apt-get install tor
mkdir /var/www/darkserver
touch /var/www/darkserver/index.html
vim /etc/tor/torrc

	HiddenServiceDir /var/lib/tor/hidden_service/
  HiddenServicePort 80 127.0.0.1:5631
  HiddenServicePort 443 127.0.0.1:5631

sudo systemctl restart tor

# Récupérer l'URL en .onion
cat /var/lib/tor/hidden_service/hostname

# Lancer le service avec python ou updog
python3 -m http.server --bind 127.0.0.1 5631

sudo apt install -y python3-pip
pip3 install updog
export PATH=$PATH:/home/kali/.local/bin 
updog -p 5631 --ssl

```
