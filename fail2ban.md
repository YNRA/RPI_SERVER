# Fail2Ban

Etant donné que nous utilisons du SSH (bien que configurer uniquement pour l'authentification par clés) et que nous exposons un serveur web (actuellement accessible uniquement par le VPN), nous avons mis en place Fail2Ban.

```bash
sudo apt-get install fail2ban
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.d/custom.conf
sudo vim /etc/fail2ban/jail.local

  ignoreip = 10.6.0.0/29

  [sshd]
  port = ssh
  enabled = true
  filter = sshd
  banaction = iptables-multiport
  bantime = -1
  maxretry = 3
  logpath = %(sshd_log)s
  backend = %(sshd_backend)s
 
 sudo systemctl restart fail2ban

# Checker le statut des jails
sudo fail2ban-client status

# Bannir une IP manuellement
fail2ban-client set [jail_name] banip [IP]

# Checker les logs
sudo tail -f /var/log/fail2ban.log
```

Pour le serveur Apache, une configuration par défaut est présente, et bloque les bots crawleurs.