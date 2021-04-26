echo "Applying rules, starting firewall ..."
sleep 1

# FLUSH RULES & START FIREWALL
iptables -t filter -F
iptables -t filter -X

# STRICT POLICY
iptables -t filter -P INPUT DROP
iptables -t filter -P OUTPUT DROP
iptables -t filter -P FORWARD DROP

# ACCEPT ESTABLISHED INBOUND CONNECTIONS
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# ACCEPT ICMP FROM VPN NETWORK
iptables -A INPUT -p icmp -s 10.6.0.0/29 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT

# ACCEPT LOOPBACK, DROP TRAFFIC TO 127.0 THAT DOESN'T USE LO
iptables -A INPUT -i lo -j ACCEPT

# ALLOW OUTBOUND TRAFFIC
iptables -A OUTPUT -j ACCEPT

# ALLOW INPUT TRAFFIC FROM MANDATORY PORTS
iptables -A INPUT -p tcp --dport 80 -m state --state NEW -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -m state --state NEW -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -s 10.6.0.0/29 -m state --state NEW -j ACCEPT
iptables -A INPUT -p tcp --dport 53 -m state --state NEW -j ACCEPT
iptables -A INPUT -p udp --dport 53 -m state --state NEW -j ACCEPT

# samba
iptables -A INPUT -p tcp --dport 139 -s 10.6.0.0/29 -m state --state NEW -j ACCEPT
iptables -A INPUT -p tcp --dport 445 -s 10.6.0.0/29 -m state --state NEW -j ACCEPT
iptables -A INPUT -p udp --dport 137 -s 10.6.0.0/29 -m state --state NEW -j ACCEPT
iptables -A INPUT -p udp --dport 138 -s 10.6.0.0/29 -m state --state NEW -j ACCEPT
iptables -A INPUT -p udp --dport 445 -s 10.6.0.0/29 -m state --state NEW -j ACCEPT

#elk
iptables -A INPUT -p udp --dport 5601 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -p tcp --dport 5601 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT

# connection au vpn
iptables -A INPUT -p udp --dport 51330 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -p tcp --dport 51330 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT

iptables -A INPUT -s 192.168.1.0/24 --state ESTABLISHED, RELATED, NEW -j ACCEPT
iptables -A INPUT -s 192.168.1.0/24 --state ESTABLISHED, RELATED, NEW -j ACCEPT

echo "Done ! Rules applied : "
sleep 1
iptables -L