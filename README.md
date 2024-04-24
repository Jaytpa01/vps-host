# VPS Host Setup

This repo is used to store any and all setup files needed for a VPS to run any of my side projects.

This assumes my projects are built as Docker images, and probably uploaded to my DigitalOcean container registry.

The setup.sh script is meant to work on a Digital Ocean Ubuntu 23.10 x64 VM.

## Instructions

1. `ssh root@YOUR_SERVER_UP`
1. Add a new user

   ```bash
   ssh root@YOUR_SERVER_UP
   adduser NEW_USER_NAME
   usermod -aG sudo NEW_USER_NAME
   rsync --archive --chown=NEW_USER_NAME:NEW_USER_NAME ~/.ssh /home/NEW_USER_NAME
   ```

1. Open a new SSH session with the newly created user  
   `ssh NEW_USER_NAME@YOUR_SERVER_IP`
1. Check for updates  
   `sudo apt update && sudo apt upgrade -y`

1. Pull this repo and start installing things

   ```bash
   git clone https://github.com/Jaytpa01/vps-host
   cd vps-host
   sudo chmod +x install-docker.sh
   sudo ./install-docker.sh
   sudo usermod -aG docker NEW_USER_NAME
   ```

## Setting up SSH Login Notifications

1. Move the script and make it executable

   ```bash
   cd ~/vps-host
   sudo cp ntfy/ntfy-ssh-login.sh /usr/bin/
   sudo nano /usr/bin/ntfy-ssh-login.sh
   sudo chmod +x /usr/bin/ntfy-ssh-login.sh
   ```

1. `sudo nano /etc/pam.d/sshd`

   ```bash
   # at the end of the file
   session optional pam_exec.so /usr/bin/ntfy-ssh-login.sh
   ```

## Setting up Gatus

If you want gatus alerts sent to a ntfy topic that needs a token with write permissions:

1. `echo "GATUS_NTFY_TOKEN=put_your_token_here" | sudo tee /etc/gatus/gatus.env`
