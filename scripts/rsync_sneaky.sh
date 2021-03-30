rsync --verbose -e "ssh -p 22" --recursive --update --archive --compress  --omit-dir-times sneaky@10.6.0.1:/home/shared/ /home/shared/
rsync --verbose -e "ssh -p 22" --recursive --update --archive --compress  --omit-dir-times /home/shared/ sneaky@10.6.0.1:/home/shared/
