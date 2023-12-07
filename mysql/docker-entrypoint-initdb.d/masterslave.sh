#!/bin/sh

if [ $MYSQL_ROLE = "master" ]; then

    echo "MYSQL_ROLE set to $MYSQL_ROLE"
    cp /etc/default/template/mysql-conf.d/master.cnf /etc/mysql/conf.d/

    mysql -uroot -p$MYSQL_ROOT_PASSWORD \
    --execute="CREATE USER 'replication_user'@'%' IDENTIFIED BY 'bigs3cret'; \
    GRANT REPLICATION SLAVE ON *.* TO 'replication_user'@'%'; FLUSH PRIVILEGES; \
    FLUSH TABLES WITH READ LOCK;"

else

    echo "MYSQL_ROLE set to slave"
    cp /etc/default/template/mysql-conf.d/slave.cnf /etc/mysql/conf.d/

 # CHANGE MASTER TO
 # MASTER_HOST='ghost-db-master',
 # MASTER_USER='replication_user',
 # MASTER_PASSWORD='bigs3cret',
 # MASTER_PORT=3306,
 # MASTER_LOG_FILE='master1-bin.000096',
 # MASTER_LOG_POS=157,
 # MASTER_CONNECT_RETRY=10;
 # START SLAVE;

fi
    