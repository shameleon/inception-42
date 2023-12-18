#!/bin/sh

service mariadb start;

# chown -R mariadb:mariadb /var/lib/mariadb
mariadb -u root -e "CREATE DATABASE IF NOT EXISTS ${DB_DATABASE};"
mariadb -u root -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_USER_PASSWORD}';"
mariadb -u root -e "GRANT ALL PRIVILEGES ON *.* TO '${DB_USER}'@'%' IDENTIFIED BY '${DB_USER_PASSWORD}';"
mariadb -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '${DB_ROOT_PASSWORD}';"
mariadb -u root -e "FLUSH PRIVILEGES;"

# disable root login without password
mariadb -u root -e "ALTER USER 'root'@'127.0.0.1' IDENTIFIED by '${DB_ROOT_PASSWORD}';"
mariadb -u root -p${DB_ROOT_PASSWORD} "CREATE DATABASE IF NOT EXISTS 'test'";
sleep 5
service mariadb stop;

# restart the mariadb service ssafe mode
exec $@
