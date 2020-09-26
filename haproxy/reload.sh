#!/bin/bash

cp /root/cluster-starter-kit/haproxy/haproxy.cfg /etc/haproxy/haproxy.cfg
systemctl reload haproxy
echo "show servers state" | socat stdio /var/run/haproxy.sock > /usr/local/haproxy/haproxy.state
#haproxy -f /etc/haproxy/haproxy.cfg -p /run/haproxy.pid -sf $(cat /run/haproxy.pid) -x /var/run/haproxy.sock