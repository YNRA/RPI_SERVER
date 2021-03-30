rsync --verbose -e "ssh -p 2222" --recursive --update --times --archive --compress --group sneaky@10.6.0.1:/home/shared/ /home/shared/
rsync --verbose -e "ssh -p 2222" --recursive --update --times --archive --compress --group /home/shared/ sneaky@10.6.0.1:/home/shared/
