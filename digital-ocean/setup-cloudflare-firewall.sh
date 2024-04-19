#!/bin/bash

FIREWALL_NAME="behind-cloudflare"

# create a firewall with basic outbound rules, and accepting SSH
BASIC_OUTBOUND_RULES="protocol:icmp,address:0.0.0.0/0,address:::/0 protocol:tcp,ports:0,address:0.0.0.0/0,address:::/0 protocol:udp,ports:0,address:0.0.0.0/0,address:::/0"
INBOUND_SSH="protocol:tcp,ports:22,address:0.0.0.0/0,address:::/0"
doctl compute firewall create --name $FIREWALL_NAME --outbound-rules "$BASIC_OUTBOUND_RULES" --inbound-rules "$INBOUND_SSH"

# grab the firewall ID from the name
FIREWALL_ID=$(doctl compute firewall ls --no-header --format ID,Name | grep $FIREWALL_NAME | awk '{print $1}')

# create a tag and bind firewall to tag
CLOUDFLARE_TAG="behind-cloudflare"
doctl compute tag create $CLOUDFLARE_TAG
doctl compute firewall add-tags $FIREWALL_ID --tag-names $CLOUDFLARE_TAG


# grab public list of trusted cloudflare proxy ids
CLOUDFLARE_IP_ADDRESSES=$(curl -s -w "\n" https://www.cloudflare.com/ips-v4/ https://www.cloudflare.com/ips-v6/ \
    | awk '{printf("address:%s\n", $1)}' \
    | paste -sd ",")

INBOUND_CLOUDFLARE_HTTPS="protocol:tcp,ports:443,$CLOUDFLARE_IP_ADDRESSES"
INBOUND_CLOUDFLARE_HTTP="protocol:tcp,ports:80,$CLOUDFLARE_IP_ADDRESSES"

doctl compute firewall add-rules $FIREWALL_ID --inbound-rules "$INBOUND_CLOUDFLARE_HTTPS"
doctl compute firewall add-rules $FIREWALL_ID --inbound-rules "$INBOUND_CLOUDFLARE_HTTP"