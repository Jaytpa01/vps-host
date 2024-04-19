#!/bin/bash

OLD_RULES=$(sudo ufw status numbered \ 
    # get current http(s) rules
    | grep 80,443/tcp \ 
    # get the numbers (i.e everything between brackets)
    | awk -F "[][]" '{print 2}' \
    # delete whitespace and sort reversed. We sort reversed so that the numbers down't change as we go through deleting the rules
    | tr --delete [:blank:] | sort -rn)

for NUM in $OLD_RULES; do
  yes | sudo ufw delete $NUM
done

for IP in $(curl -s https://www.cloudflare.com/ips-v4/); do
do
    sudo ufw allow from $IP to any port 80,443 proto tcp
done

for IPV6 in $(curl -s https://www.cloudflare.com/ips-v6/); do
    sudo ufw allow from $IPV6 to any port 80,443 proto tcp
done