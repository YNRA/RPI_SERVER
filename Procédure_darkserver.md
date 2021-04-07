apt-get install tor
mkdir /var/www/darkserver
mettre l'html dedans
python3 -m http.server --bind 127.0.0.1 5631

dans /etc/tor/torrc l71 decomenter et changer le port
HiddenServiceDir /var/lib/tor/hidden_service/
HiddenServicePort 80 127.0.0.1:5631
HiddenServicePort 443 127.0.0.1:5631

redemarrer tor (sudo service tor restart )
cat /var/lib/tor/hidden_service/hostname
ztbq2emkuuulqykwn43cj5il3w7x3xk5b5dzcqahiedwz6t5svdv4sqd.onion

SI ON PEUT INSTALLER UPOG
<!-- sudo apt update
sudo apt install -y python3-pip
pip3 install updog
export PATH=$PATH:/home/kali/.local/bin 
LANCER çA a la place du python 
updog -p 5631 --ssl-->