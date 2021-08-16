#!/bin/bash 
echo "Add Mina Repo to apt-get"
echo "deb [trusted=yes] http://packages.o1test.net release main" | sudo tee /etc/apt/sources.list.d/mina.list
sudo apt-get update
sudo apt-get install -y curl unzip mina-mainnet=1.1.5-a42bdee

adduser minar
usermod -aG sudo minar
usermod -aG systemd-journal minar
mkdir -p /home/minar/.ssh
chown minar:minar /home/minar/.ssh
sudo cp /root/.ssh/authorized_keys /home/minar/.ssh/authorized_keys
sudo chown minar:minar /home/minar/.ssh/authorized_keys
sudo chmod 600 /home/minar/.ssh/authorized_keys
sudo systemctl restart sshd

sudo apt -y update
sudo apt -y full-upgrade
sudo apt-get install -y apt-transport-https ca-certificates gnupg
sudo apt-get install -y curl


YOUR_HOST_IP="$(curl https://api.ipify.org)"
THE_SEEDS_URL=https://storage.googleapis.com/mina-seed-lists/mainnet_seeds.txt
YOUR_COINBASE_RECEIVER=B62qoigHEtJCoZ5ekbGHWyr9hYfc6fkZ2A41h9vvVZuvty9amzEz3yB
MINA_VERSION=mina-mainnet=1.1.5-a42bdee
