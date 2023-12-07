FROM mysql:8.2

COPY docker-entrypoint-initdb.d/ /docker-entrypoint-initdb.d/

RUN chmod -R 555 /docker-entrypoint-initdb.d/ \
   && mkdir -p /etc/default/template/mysql-conf.d \
   && chown mysql:mysql /etc/mysql/conf.d/

COPY conf.d/ /etc/default/template/mysql-conf.d