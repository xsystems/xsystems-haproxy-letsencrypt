# xSystems HAProxy Let’s Encrypt

Docker service that acts as a (layer 4 / layer 7) proxy and makes use of Let’s Encrypt.

## Use the Image

1. Create a HAProxy configuration file called `haproxy.cfg`, in which your domain certificate path is: `/usr/local/etc/haproxy/certs/${PROXY_DOMAIN}.pem`
2. Create a Dockerfile:

        FROM xsystems/haproxy-letsencrypt:latest
        COPY haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg

3. Build your image using the Dockerfile:

        docker build --tag my-haproxy-letsencrypt .

4. Before using the just created image, set the following environment variables:

| Environment Variable                | Default Value | Description                                           | Required  |
| :---------------------------------- | :------------ | :---------------------------------------------------- | :-------: |
| PROXY_DOMAIN                        |               | A domain your machine can be reached at.              |     ✔     |
| PROXY_EMAIL                         |               | An email for error reporting.                         |           |
| PROXY_CERTIFICATE_RENEWAL_INTERVAL  | 0 7,19 * * *  | How often should be checked for certificate expiry.   |           |
| PROXY_STAGING_DISABLED              | false         | Disable staging mode i.e. issue trusted certificates. |           |


## Build the Image

Run the [build.sh](build.sh) script.


## Release the Image

1. Make sure you are allowed to push to the `xsystems` repository on Docker Hub e.g. by doing: `docker login`
2. Set the `COMMIT` environment variable to the Git commit hash of the commit that needs to be released.
3. Set the `VERSION` environment variable to the version that needs to be released.
4. Run the [release.sh](release.sh) script.
