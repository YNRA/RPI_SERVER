sudo apt-get install fail2ban
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local

edit /etc/fail2ban/jail.local

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


