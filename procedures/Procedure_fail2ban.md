sudo apt-get install fail2ban
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.d/custom.conf

edit /etc/fail2ban/jail.local


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

> save

sudo service fail2ban restart

# check status of jails
sudo fail2ban-client status

# stop particular jail
sudo fail2ban-client stop sshd

# ban ip manually
fail2ban-client set [jail_name] banip [IP]

# unban ip manually
fail2ban-client set [jail_name] unbanip [IP]

# check logs

sudo tail -f /var/log/fail2bab.log
