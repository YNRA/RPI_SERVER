curl -L https://install.pivpn.io | bash
# Follow install, choose Wireguard VPN, Static IP Address, Local user, Port (default 51820 : change to 51330), DNS Cloudfare, Use default Public IP (Arnaud 86.215.12.125), enable unattend packages
# Add a user : pivpn -a 
# Enable or disable wg : wg-quick up/down INTERFACE
# conf is copied in /home/user/configs ; copy and transfer to define user
