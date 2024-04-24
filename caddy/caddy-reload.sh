#!/bin/bash

docker compose -f ./compose.caddy.yml exec -w /etc/caddy caddy caddy reload