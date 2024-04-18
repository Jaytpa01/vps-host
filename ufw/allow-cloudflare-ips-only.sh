#!/bin/bash

#!/bin/bash
curl -s https://www.cloudflare.com/ips-v4/ | \
while IFS="" read -r IP || [ -n "$IP" ];
do
    sudo ufw allow from $IP to any port 80,443 proto tcp
done

curl -s https://www.cloudflare.com/ips-v6/ | \
while IFS="" read -r IPV6 || [ -n "$IPV6" ];
do
    sudo ufw allow from $IPV6 to any port 80,443 proto tcp
done