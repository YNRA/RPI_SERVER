# RASPBERRY PI SERVER [Group #55]


| Nom                                 | Classe | Spécialisation        |
| ----------------------------------- | ------ | --------------------- |
| Arnaud BOYÉ (@YNRA)               | B3     | Sécurité Informatique |
| Thomas DEJEANNE (@Gomonriou)        | B3     | Sécurité Informatique |

* Home server shared between us
    * Hidden Service TOR
    * Clear Web (Apache)

* VPN
* Attack device w/ mandatory tools only (Fuzzing, Network Mapping, Cracking, etc.)
    * Katoolin (install tools, update, etc.)
* Security hardening
     Partitioning
    * SSH w/ authorized keys and hosts only (us)
    * Monitoring (Netdata? Grafana? Prometheus?)
    * HIDS
    * Firewall (Pfsense? Stormshield? Iptables?)
    * Local storage
    * Backups & Restoration (CRON, DB)

**Documentation:**

* [Home server setup](https://www.instructables.com/Ultimate-Pi-Based-Home-Server/)
* [VPN Wireguard](https://pimylifeup.com/raspberry-pi-wireguard/)
* [VPN OpenVPN ](https://www.ionos.fr/digitalguide/serveur/configuration/installer-un-serveur-vpn-via-raspberry-pi-et-openvpn/)
* [TOR Server](https://pivilion.net/how-to-install-tor-with-apache-as-a-hidden-service/)
* [Access R.Pi w/ TOR](https://www.khalidalnajjar.com/access-your-raspberry-pi-globally-using-tor/)
* [Hidden service TOR](https://onionshare.org/)
* [R. PI on internet](https://raspberry-pi.fr/mettre-en-ligne-serveur-web-raspbian-dydns-port-forwarding/)
* [InfoSec tools en CentOS](https://www.unixmen.com/install-kali-linux-tools-on-ubuntu-and-centos/)
* [Synchronize directory between two hosts](https://bogdanvlviv.com/posts/rsync/how-to-synchronize-a-directory-between-two-remote-hosts-with-rsync.html)
* [IPTABLES on RPI](https://www.fanjoe.be/?p=1003)

## TO DO
* Trello ? 

## OS choice
 * 64-bits (use everything)
 * Update frequency
 * No desktop, only CLI
 * Lightweight
