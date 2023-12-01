FROM nginx:1.25-alpine

COPY etc/ /etc/nginx/
COPY 40-enable-cache.sh /docker-entrypoint.d/

RUN chmod 555 /docker-entrypoint.d/40-enable-cache.sh