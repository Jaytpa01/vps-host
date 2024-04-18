#!/bin/bash

#!/bin/bash
curl -s https://www.cloudflare.com/ips-v4/ | \
while IFS="" read -r IP || [ -n "$IP" ];
do
    echo "Cloudflare IP $IP"
done

curl -s https://www.cloudflare.com/ips-v6/ | \
while IFS="" read -r IPV6 || [ -n "$IPV6" ];
do
    echo "Cloudflare IPv6 $IPV6"
done