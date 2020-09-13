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

sudo apt install -y socat
# echo "help" | socat stdio tcp4-connect:127.0.0.1:9999
# echo "set server be_template/websrv1 addr 192.168.50.112 port 8000" | socat stdio tcp4-connect:127.0.0.1:9999

# sudo nano /etc/haproxy/haproxy.cfg