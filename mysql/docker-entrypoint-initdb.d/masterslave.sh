#!/bin/sh

if [ $MYSQL_ROLE = "master" ]; then

    echo "MYSQL_ROLE set to $MYSQL_ROLE"
    cp /etc/default/template/mysql-conf.d/master.cnf /etc/mysql/conf.d/

    echo "Creating replication user"
    mysql -uroot -p$MYSQL_ROOT_PASSWORD \
    --execute="CREATE USER 'replication_user'@'%' IDENTIFIED WITH mysql_native_password BY 'bigs3cret'; \
    GRANT REPLICATION SLAVE ON *.* TO 'replication_user'@'%'; FLUSH PRIVILEGES;"

    echo "Performing temporary backup of all databases"
    mysqldump -uroot -p$MYSQL_ROOT_PASSWORD --all-databases --master-data > /tmp/mysql-backup/master_initialization.sql

else

    echo "MYSQL_ROLE set to slave"
    cp /etc/default/template/mysql-conf.d/slave.cnf /etc/mysql/conf.d/

    mysql -uroot -p$MYSQL_ROOT_PASSWORD \
    --execute="CHANGE MASTER TO \
                    MASTER_HOST='ghost-db-master', \
                    MASTER_USER='replication_user', \
                    MASTER_PASSWORD='bigs3cret';"

    mysql -uroot -p$MYSQL_ROOT_PASSWORD < /tmp/mysql-backup/master_initialization.sql

    mysql -uroot -p$MYSQL_ROOT_PASSWORD --execute="START SLAVE;"

fi
    


