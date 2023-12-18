#!/bin/sh
service mysql start 

# chown -R mysql:mysql /var/lib/mysql
mysql -u root -e "CREATE DATABASE IF NOT EXISTS ${DB_DATABASE};"
mysql -u root -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_USER_PASSWORD}';"
mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO '${DB_USER}'@'%' IDENTIFIED BY '${DB_USER_PASSWORD}';"
mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '${DB_ROOT_PASSWORD}';"
mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED by '${DB_ROOT_PASSWORD}';"
mysql -u root -p${DB_ROOT_PASSWORD} -e "FLUSH PRIVILEGES;"
kill $(cat /run/mysqld/mysqld.pid)
mysqld
# mysqld_safe