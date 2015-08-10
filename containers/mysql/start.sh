#!/bin/bash

if [ ! -f /var/lib/mysql/ibdata1 ]; then

    mysql_install_db
    chown -R mysql:mysql /var/lib/mysql
    echo "ADDING USERS"
    /usr/bin/mysqld_safe &
    sleep 5s
    echo "GRANT ALL ON *.* TO root@'%' IDENTIFIED BY 'root' WITH GRANT OPTION; FLUSH PRIVILEGES" | mysql
    echo "GRANT ALL ON webdrupaldb.* TO webdrupal@'%' IDENTIFIED BY 'webdrupal' WITH GRANT OPTION; FLUSH PRIVILEGES" | mysql

    killall mysqld
    sleep 5s
fi

mysqld_safe & tail -f /var/log/mysqld.log
