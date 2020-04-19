#!/bin/bash
crontab -l | { cat; echo "0 0 1 * * root bash /root/cluster-starter-kit/certbot/renew.sh"; } | crontab -