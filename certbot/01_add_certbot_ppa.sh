#!/bin/bash

sudo apt-get update
sudo apt-get install software-properties-common
sudo add-apt-repository universe
sudo add-apt-respoitory ppa:certbot/certbot
sudo apt-get update
sudo apt install python3-pip
sudo pip3 install certbot-dns-cloudflare
sudo pip3 install acme==1.6.0