sudo mkdir -p /home/shared
sudo groupadd shared
sudo chgrp -R shared /home/shared
sudo chmod -R 2775 /home/shared
sudo usermod -aG shared sneaky
sudo usermod -aG shared gomonriou
