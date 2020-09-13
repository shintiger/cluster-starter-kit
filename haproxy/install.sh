#!/bin/bash

sudo apt show haproxy
sudo add-apt-repository ppa:vbernat/haproxy-2.0
sudo apt update
sudo apt install -y haproxy

# sudo nano /etc/haproxy/haproxy.cfg