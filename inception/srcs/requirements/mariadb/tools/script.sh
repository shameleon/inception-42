#!/bin/sh
service mariadb start 

# chown -R mariadb:mariadb /var/lib/mariadb
mariadb -u root -e "CREATE DATABASE IF NOT EXISTS ${DB_DATABASE};"
mariadb -u root -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_USER_PASSWORD}';"
mariadb -u root -e "GRANT ALL PRIVILEGES ON *.* TO '${DB_USER}'@'%' IDENTIFIED BY '${DB_USER_PASSWORD}';"
mariadb -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '${DB_ROOT_PASSWORD}';"
mariadb -u root -e "FLUSH PRIVILEGES;"

# disable root login without password
# mariadb -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED by '${DB_ROOT_PASSWORD}';"
# mariadb -u root -p${DB_ROOT_PASSWORD} -e "FLUSH PRIVILEGES;"

kill $(cat /var/run/mariadbd/mariadbd.pid)