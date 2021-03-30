rsync --verbose -e "ssh -p 22" --recursive --update --archive --compress  --omit-dir-times gomonriou@10.6.0.2:/home/shared/ /home/shared/
rsync --verbose -e "ssh -p 22" --recursive --update --archive --compress  --omit-dir-times /home/shared/ gomonriou@10.6.0.2:/home/shared/
