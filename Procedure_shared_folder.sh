sudo mkdir -p /home/shared
sudo groupadd shared
sudo chgrp -R shared /home/shared
sudo chmod -R 2775 /home/shared
useradd -D -g shared sneaky
useradd -D -g shared gomonriou
