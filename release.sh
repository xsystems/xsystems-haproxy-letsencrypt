#!/bin/sh

if [ -z "${COMMIT}" ]; then
  echo "The COMMIT environment variable is NOT set, but is required."
fi

if [ -z "${VERSION}" ]; then
  echo "The VERSION environment variable is NOT set, but is required."
fi

git tag --annotate --message "Release ${VERSION}" ${VERSION} ${COMMIT}
git push origin ${VERSION}

docker build --tag xsystems/haproxy-letsencrypt:${VERSION} "https://github.com/xsystems/xsystems-haproxy-letsencrypt.git#${COMMIT}"
docker tag xsystems/haproxy-letsencrypt:${VERSION} xsystems/haproxy-letsencrypt:latest
docker push xsystems/haproxy-letsencrypt:${VERSION}
docker push xsystems/haproxy-letsencrypt:latest
