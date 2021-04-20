echo "Applying rules, starting firewall ..."
#sleep 1

# FLUSH RULES
iptables -t filter -F
iptables -t filter -X

# STRICT POLICY
iptables -t filter -P INPUT DROP
iptables -t filter -P OUTPUT DROP
iptables -t filter -P FORWARD DROP

# ACCEPT ESTABLISHED INBOUND CONNECTIONS
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# DROP XMAS, NULL, PORTS SCANS
iptables -A INPUT -p tcp --tcp-flags FIN,URG,PSH FIN,URG,PSH -j DROP
iptables -A INPUT -p tcp --tcp-flags ALL ALL -j DROP
iptables -A INPUT -p tcp --tcp-flags ALL NONE -j DROP
iptables -A INPUT -p tcp --tcp-flags SYN,RST SYN,RST -j DROP
iptables -A FORWARD -p tcp --tcp-flags SYN,ACK,FIN,RST RST -m limit --limit 1/s -j ACCEPT

# ACCEPT FROM VPN NETWORK
iptables -A INPUT -s 10.6.0.0/29 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT

# ACCEPT LOOPBACK, DROP TRAFFIC TO 127.0 THAT DOESN'T USE LO
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -d 127.0.0.0/8 -j REJECT

# ALLOW OUTBOUND TRAFFIC
iptables -A OUTPUT -j ACCEPT

# ALLOW INPUT TRAFFIC FROM MANDATORY PORTS
iptables -A INPUT -p tcp --dport 80 -m state --state NEW -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -m state --state NEW -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -m state --state NEW -j ACCEPT
iptables -A INPUT -p tcp --dport 53 -m state --state NEW -j ACCEPT
iptables -A INPUT -p udp --dport 53 -m state --state NEW -j ACCEPT
iptables -A INPUT -p tcp --sport 51330 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -p udp --sport 51330 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -p tcp --dport 51330 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -p udp --dport 51330 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT

# VPN ROUTE
# NAT RULES
iptables -t nat -A POSTROUTING 1 -s 10.6.0.0/29 -o wlan0 -j MASQUERADE
iptables -t nat -A POSTROUTING 1 -s 10.6.0.0/29 -o eth0 -j MASQUERADE
# ACCEPT TRAFFIC CREATED BY WG0 INTERFACE
iptables -A INPUT -i wg0 -j accept
# ALLOW PACKET BEING ROUTED THROUGH WG SERVER 
iptables -A FORWARD 1 -i eth0 -o wg0 -j ACCEPT
iptables -A FORWARD 1 -i wlan0 -o wg0 -j ACCEPT
iptables -A FORWARD 1 -i wg0 -o eth0 -j ACCEPT
iptables -A FORWARD 1 -i wg0 -o wlan0 -j ACCEPT

# LOG DENIED IP
iptables -A INPUT -m limit --limit 5/min -j LOG --log-prefix "IPTABLES DENIED: " --log-level 7

# TURN ON IP FORWARDING
sysctl -w net.ipv4.ip_forward=1

echo "Done ! Rules applied : "
#sleep 1
iptables -L
