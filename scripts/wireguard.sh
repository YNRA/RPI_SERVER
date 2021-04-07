curl -L https://install.pivpn.io | bash
# Follow install, choose Wireguard VPN, Static IP Address, Local user, Port (default 51820 : change to 51330), DNS Cloudfare, Use default Public IP (Arnaud 86.215.12.125), enable unattend packages
# Add a user : pivpn -a 
# Enable or disable wg : wg-quick up/down INTERFACE
# conf is copied in /home/user/configs ; copy and transfer to define user


# HOTE 
[Interface]
PrivateKey = eA0GLDZ/+rnD9DOSyt/GDNRPr9EDDQlQ3X1cFQGMxGs=
Address = 10.6.0.4/29
DNS = 1.1.1.1, 8.8.8.8

[Peer]
PublicKey = 0G37Umm89r00hEn9oI5a4/fmeqlBcgHW61K+ecAN9Wg=
PresharedKey = ob1D5eW6Dw7R7hpsVTnLhtlxyo7GpLvUpGiYWfJPCNA=
Endpoint = 90.120.170.212:51330
AllowedIPs = 10.6.0.1/32


# RPI 
[Interface]
Address = 10.6.0.1/29
ListenPort = 51330
PrivateKey = WEow/EnyBDJ4zmyk3Yn7WDWivruKfbYHsqdv+nfPt2I=

[Peer]
PublicKey = xtvu53T/hWltoyJhWDwKpAJhoxJKd+I8OMZQqAucWiQ=
PresharedKey = N8ro0hnHiCANsP8zxxi6eYZMLF5ZT+Sw5nUx9ABT1CE=
AllowedIPs = 10.6.0.2/32
Endpoint = 86.215.12.125:51330
### begin gomonriou_ubuntu ###
[Peer]
PublicKey = UCnx4CjKIF7yc853KPAxvUaZIp8hpgRzcNCpSMSaglY=
PresharedKey = ob1D5eW6Dw7R7hpsVTnLhtlxyo7GpLvUpGiYWfJPCNA=
AllowedIPs = 10.6.0.4/32
### end gomonriou_ubuntu ###
