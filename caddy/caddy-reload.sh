#!/bin/bash

docker compose -f ./caddy/docker-compose.yaml exec -w /etc/caddy caddy caddy reload