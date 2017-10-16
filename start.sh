#!/bin/sh
set -e

if [ -n "${PROXY_STAGING_DISABLED}" ]; then
  sed -i "/^staging/d" /usr/local/etc/letsencrypt/letsencrypt.ini
fi

if [ -n "${PROXY_CERTIFICATE_RENEWAL_INTERVAL}" ]; then
  echo "${PROXY_CERTIFICATE_RENEWAL_INTERVAL} certbot renew --config /usr/local/etc/letsencrypt/letsencrypt.ini" | crontab -
else
  echo "0 7,19 * * * certbot renew --config /usr/local/etc/letsencrypt/letsencrypt.ini" | crontab -
fi

if [ -n "${PROXY_EMAIL}" ]; then
  echo "email = ${PROXY_EMAIL}" >> /usr/local/etc/letsencrypt/letsencrypt.ini
fi

for PROXY_DOMAIN in ${PROXY_DOMAINS} ; do
  certbot certonly --config /usr/local/etc/letsencrypt/letsencrypt.ini --domains ${PROXY_DOMAIN}
done

. /usr/local/etc/letsencrypt/letsencrypt-hook-pre.sh
. /usr/local/etc/letsencrypt/letsencrypt-hook-post.sh

exec crond -f
