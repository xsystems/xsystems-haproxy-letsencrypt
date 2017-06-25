FROM haproxy:1.7-alpine

MAINTAINER xsystems

RUN apk add --no-cache certbot

COPY  letsencrypt.ini \
      letsencrypt-hook-pre.sh \
      letsencrypt-hook-post.sh      /usr/local/etc/letsencrypt/
COPY  start.sh                      /usr/local/bin/

ENTRYPOINT ["sh", "-c"]

CMD ["start.sh"]
