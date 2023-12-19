#!/bin/sh

# if [ ! -d "/run/mysqld" ];
# then
#     mkdir -p /run/mysqld
#     chown -R mysql:mysql /run/mysqld
# fi

# if [ ! -d "/var/lib/mysql/mysql" ];
# then
#     chown -R mysql:mysql /var/lib/mysql
#     mariadb-install-db --user=mysql --datadir=/var/lib/mysql --basedir=/usr --rpm > /dev/null
# fi

# service mariadb start;
#mariadb --user=root --datadir=/var/lib/mysql
if [ -d "/var/lib/mysql/${DB_DATABASE}" ];
then 
	echo "The ${DB_DATABASE} database is already there.";
else
	sleep 2;
	echo "The ${DB_DATABASE} database is being created.";
	mariadb -u root -e "CREATE DATABASE IF NOT EXISTS ${DB_DATABASE};"
	mariadb -u root -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_USER_PASSWORD}';"
	mariadb -u root -e "GRANT ALL PRIVILEGES ON *.* TO '${DB_USER}'@'%' IDENTIFIED BY '${DB_USER_PASSWORD}';"
	mariadb -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '${DB_ROOT_PASSWORD}';"
	mariadb -u root -e "FLUSH PRIVILEGES;"

	# disable root login without password
	mariadb -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED by '${DB_ROOT_PASSWORD}';"
	mariadb -u root -p${DB_ROOT_PASSWORD} "CREATE DATABASE IF NOT EXISTS 'test'";
	# mariadbd --user=mysql < /mariadb.sql
	# service mariadb stop;
	pkill mysqld
fi
# restart the mariadb service in safe mode
# exec "$@"
# exec "mysqld_safe";
# exec mysqld --bind-address=0.0.0.0;
exec  mysqld --user=mysql --bootstrap;