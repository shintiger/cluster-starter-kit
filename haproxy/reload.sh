#!/bin/bash

haproxy -f /etc/haproxy/haproxy.cfg -p /run/haproxy.pid -sf $(cat /run/haproxy.pid) -x /var/run/haproxy.sock