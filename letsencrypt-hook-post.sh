#!/bin/sh
set -e
mkdir -p /usr/local/etc/haproxy/certs
for PROXY_DOMAIN in ${PROXY_DOMAINS} ; do
  cat /etc/letsencrypt/live/${PROXY_DOMAIN}/fullchain.pem /etc/letsencrypt/live/${PROXY_DOMAIN}/privkey.pem > /usr/local/etc/haproxy/certs/${PROXY_DOMAIN}.pem
done
haproxy -D -f /usr/local/etc/haproxy/haproxy.cfg &
