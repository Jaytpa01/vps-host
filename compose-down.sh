#!/bin/bash

COMPOSE_FILES=$(ls | grep "compose.*.yml")
DOCKER_FILE_PATHS=$(printf -- "-f %s " $COMPOSE_FILES)

docker compose $DOCKER_FILE_PATHS down