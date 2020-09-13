#!/bin/bash

sudo apt show haproxy
sudo add-apt-repository ppa:vbernat/haproxy-2.0
sudo apt update
sudo apt install -y haproxy

mkdir dataplaneapi
pushd dataplaneapi
wget https://github.com/haproxytech/dataplaneapi/releases/download/v2.1.0/dataplaneapi_2.1.0_Linux_x86_64.tar.gz
tar -zxvf dataplaneapi_2.1.0_Linux_x86_64.tar.gz
pushd build
chmod +x dataplaneapi
sudo cp dataplaneapi /usr/local/bin/ 
popd
popd
rm -rf dataplaneapi

sudo cp dataplaneapi.service /etc/systemd/system/

# sudo nano /etc/haproxy/haproxy.cfg