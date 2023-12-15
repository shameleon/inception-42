#!/bin/sh
service mysql start 

mysql -u root -e "CREATE USER '${DB_USER}'@'%' IDENTIFIED BY '${DB_USER_PASSWORD}';"
mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO '${DB_USER}'@'%' IDENTIFIED BY '${DB_USER_PASSWORD}';"
mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '${DB_ROOT_PASSWORD}';"
mysql -u root -e "FLUSH PRIVILEGES;"
mysql -u root -e "CREATE DATABASE  IF NOT EXISTS ${DB_DATABASE};"
mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED by '${DB_ROOT_PASSWORD}'";

kill $(cat /run/mysqld/mysqld.pid)
mysqld