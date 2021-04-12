# install docker 
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker gomonriou
docker version
docker run hello-world

# install docker-compose
sudo apt-get install libffi-dev libssl-dev
sudo apt install python3-dev
sudo apt-get install -y python3 python3-pip
sudo pip3 install docker-compose
sudo systemctl enable docker

wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
sudo apt-get update -y && sudo apt-get install elasticsearch
sudo systemctl start elasticsearch
sudo journalctl -f -u elasticsearch
curl localhost:9200
Les configurations Elasticsearch sont effectuées à l'aide du fichier de configuration /etc/elasticsearch/elasticsearch.yml qui vous permet de configurer les paramètres généraux comme par exemple le nom du nœud, ainsi que les paramètres réseau comme par exemple l'hôte et le port, l'emplacement des données stockées, la mémoire, les fichiers de logs, etc... Pour ce cours nous laisserons la configuration par défaut.

sudo apt-get install kibana
Le fichier de configuration de kibana se retrouve dans /etc/kibana/kibana.yml . Si jamais vous avez modifié avec ce fichier, assurez-vous juste que la configuration kibana possède les bonnes informations pour communiquer avec Elasticsearch :
sudo systemctl start kibana
sudo journalctl -f -u kibana
Pour tester Kibana, ouvrez dans votre navigateur l'url http://localhost:5601 afin de voir la page d'accueil Kibana :

sudo apt-get install default-jre
java -version
sudo apt-get install logstash
Le fichier de configuration de Logstash est le suivant : /etc/logstash/logstash.yml et permet de configurer des paramètres généraux comme par exemple le nom du nœud, le port, le niveau des logs etc... Pour ce cours nous laisserons la configuration par défaut.
sudo systemctl start logstash
sudo journalctl -f -u logstash
