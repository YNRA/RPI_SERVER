# Installation de la stack ELK

## Elasticsearch (moteur de recherche)
Les configurations Elasticsearch sont effectuées à l'aide du fichier de configuration /etc/elasticsearch/elasticsearch.yml qui  permet de configurer les paramètres généraux comme par exemple le nom du nœud, ainsi que les paramètres réseau comme par exemple l'hôte et le port, l'emplacement des données stockées, la mémoire, les fichiers de logs, etc... 

```bash
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
sudo apt-get update -y && sudo apt-get install elasticsearch
sudo systemctl start elasticsearch
sudo journalctl -f -u elasticsearch
curl localhost:9200
```



## Kibana (visualisation)
Le fichier de configuration de kibana se retrouve dans /etc/kibana/kibana.yml 
```bash
sudo apt-get install kibana
sudo systemctl start kibana
```

### Exposition de l'interface graphique sur le vpn
```bash
sudo nano /etc/kibana/kibana.yml
server.host: "10.6.0.1"
sudo journalctl -f -u kibana
```

Pour tester Kibana, ouvrir dans le navigateur l'URL http://localhost:5601 afin de voir la page d'accueil Kibana :

## Logstash (parseur de log et pipeline pour elasticsearch)

Le fichier de configuration de Logstash est le suivant : /etc/logstash/logstash.yml et permet de configurer des paramètres généraux comme par exemple le nom du nœud, le port, le niveau des logs etc... 

```bash
sudo apt-get install default-jre
java -version
sudo apt-get install logstash
sudo systemctl start logstash
sudo journalctl -f -u logstash
```

## Filebeat 

```bash
sudo apt-get install filebeat
sudo systemctl enable filebeat
```

le path du fichier de conf de filebeat est /etc/filebeat/filebeat.yml

### module préfait de filebeat

```bash
sudo filebeat modules list
sudo filebeat modules enable XXXX
sudo filebeat setup
sudo service filebeat start
```



## Dashboard perso

Dans le fichier de configuration de Samba (/etc/samba/smb.conf) nous avons préalablement fait en sorte qu'ils nous produisent des logs en suivant un 'pattern', pour faire le lien entre ce fichier de log et notre monitoring (ELK) il faut tout d'abord les parser puis les envoyer à elasticsearch.

Ajouter logstash au groupe adm qui est utilisé pour le monitoring system :

````bash
sudo usermod -aG adm logstash
````

Nous pouvons ensuite créer et remplir le fichier de configuration /etc/logstash/conf.d/samba.conf, il faut le composer en 3 points:
- input en renseignant le fichier de log souhaité du type file ici (il faut indiquer explicitement 'sincedb_path' -> répertoire où logstash a l'autorisation d'écriture pour le registre )

- le filtre qui doit etre construit en fonction de la structure du fichier de log ici:
    
- ````bash
    mutate { gsub => ["message","\|",":"] }
    grok { match => { "message" => "%{MONTH:syslog_month} %{MONTHDAY:syslog_day} %{TIME:syslog_time} localhost smbd\[%{INT:pid}\]: %{USER:user_service}:%{USER:user_session}:%{IP:client_ip}:%{HOSTNAME:client_NETBIOS}$ }
    ````
    
- l'output (stdout {} est tres pratique pour le debug) puis en production mettre sur elasticsearch en precisant l'host et un index (commençant par logstash-XXX)

Logstash propose plusieurs options pratiques -t (pour contrôler automatiquement notre fichier de configuration) et --debug (afin d'avoir plus de log)

```bash
sudo -u logstash /usr/share/logstash/bin/logstash  -f /etc/logstash/conf.d/samba.conf (-t/--debug)
```

Nous pouvons maintenant récupérer notre index (logstash-XXX) dans kibana/management/index et créer les visualisations que l'on souhaite intégrer a nos dashboards

( Une autre manière de faire consiste à récupérer les logs depuis 'syslog' avec filebeat et de faire nos dashboards en filtra par exemple sur process.name pour cela rajouter juste le path du fichier de log voulu dans /etc/filebeat/filebeat.yml)

