#!/bin/bash

cp /root/cluster-starter-kit/haproxy/haproxy.cfg /etc/haproxy/haproxy.cfg
systemctl reload haproxy
#haproxy -f /etc/haproxy/haproxy.cfg -p /run/haproxy.pid -sf $(cat /run/haproxy.pid) -x /var/run/haproxy.sock