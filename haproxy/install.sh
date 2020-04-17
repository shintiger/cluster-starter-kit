#!/bin/bash

sudo apt show haproxy
sudo add-apt-repository ppa:vbernat/haproxy-1.8
sudo apt update
sudo apt install -y haproxy

# sudo nano /etc/haproxy/haproxy.cfg