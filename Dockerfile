FROM jwilder/nginx-proxy

RUN apt-get update -y \
 && apt-get install -y \
            supervisor

RUN wget -q https://dl.eff.org/certbot-auto \
 && chmod a+x ./certbot-auto \
 && mv ./certbot-auto /usr/local/bin/certbot \
 && certbot --install-only --non-interactive

# RUN wget -q https://dl.minio.io/client/mc/release/linux-amd64/mc \
#  && mv ./mc /usr/local/bin/mc \
#  && chmod a+x /usr/local/bin/mc
#
# ENV S3FS_ENDPOINT=https://s3.wasabisys.com \
#     S3FS_ACCESSKEY=HTGT0EK60QR7KT3WA79I \
#     S3FS_SECRETKEY=EmggKIe499mBQYOU1bETGLqDrawYr1nHzVsibPXY \
#     DEBUG=false \
#     DOCKER_HOST=unix:///tmp/docker.sock
#
# RUN mc config host add wasabi $S3FS_ENDPOINT $S3FS_ACCESSKEY $S3FS_SECRETKEY
#
# RUN mc mb nginx-confd
# RUN mc mb nginx-certs

# RUN mkdir -p /etc/supervisor/conf.d

# COPY ./supervisor/* /etc/supervisor/conf.d/

COPY ./Procfile /app/Procfile

RUN certbot register -n -m joeri.veder@comsave.com --agree-tos
