#!/bin/sh
sleep 2
rsync --verbose -e "ssh -p 22" --recursive --update --archive --compress --times --delete  /home/shared/ gomonriou@10.6.0.2:/home/shared/
rsync --berbose -e "ssh -p 22" --recursive --update --archive --compress --times --delete gomonirou@10.6.0.2:/home/shared/ /home/shared/
