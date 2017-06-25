#!/bin/sh
set -e
mkdir -p /usr/local/etc/haproxy/certs
cat /etc/letsencrypt/live/${PROXY_DOMAIN}/fullchain.pem /etc/letsencrypt/live/${PROXY_DOMAIN}/privkey.pem > /usr/local/etc/haproxy/certs/${PROXY_DOMAIN}.pem
haproxy -D -f /usr/local/etc/haproxy/haproxy.cfg &
