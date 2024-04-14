# VPS Host Setup

This repo is used to store any and all setup files needed for a VPS to run any of my side projects.

This assumes my projects are built as Docker images, and probably uploaded to my DigitalOcean container registry.

The setup.sh script is meant to work on a Digital Ocean Ubuntu 23.10 x64 VM.

## Instructions

1. `ssh root@YOUR_SERVER_UP`
1. If this is a new vps, setup a new non-root user following [this guide](https://www.digitalocean.com/community/tutorials/initial-server-setup-with-ubuntu#step-2-creating-a-new-user)
1. Open a new SSH session with the newly created user
1. `cd ~`
1. `git clone https://github.com/Jaytpa01/vps-host`
1. `cd vps-host`
1. `sudo chmod +x setup.sh`
1. `sudo ./setup.sh`
1. `sudo docker compose up -d`

## Setting up SSH Login Notifications

1. `cd ~/vps-host`
1. `sudo cp ntfy/ntfy-ssh-login.sh /usr/bin/`
1. `sudo nano /usr/bin/ntfy-ssh-login.sh` and update or remove the ntfy Authorization header stub
1. `sudo chmod +x /usr/bin/ntfy-ssh-login.sh`
