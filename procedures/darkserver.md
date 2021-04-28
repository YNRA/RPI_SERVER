# Installer le service TOR
apt-get install tor

# Créer le dossié du service web
mkdir /var/www/darkserver
touch /var/www/darkserver/index.html

# Configuration TOR
dans /etc/tor/torrc l71 decommenter et changer le port
HiddenServiceDir /var/lib/tor/hidden_service/
HiddenServicePort 80 127.0.0.1:5631
HiddenServicePort 443 127.0.0.1:5631
puis redemarrer tor -> sudo service tor restart

# récupérer l'URL 
cat /var/lib/tor/hidden_service/hostname
ztbq2emkuuulqykwn43cj5il3w7x3xk5b5dzcqahiedwz6t5svdv4sqd.onion

# install UPOG
sudo apt install -y python3-pip
pip3 install updog
export PATH=$PATH:/home/kali/.local/bin 

# lancer le service

<!-- python3 -m http.server --bind 127.0.0.1 5631 -->
updog -p 5631 --ssl