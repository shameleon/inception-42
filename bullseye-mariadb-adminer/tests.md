### Test MariaDB alone
test_maria:

docker build -t my-mariadb ./srcs/requirements/mariadb/
docker run -tid --name testmariadb --env-file ./srcs/.env my-mariadb
docker exec -ti testmariadb bash

check env :
	env

check config :
	cat /etc/mysql/mariadb.conf.d/50-server.cnf

start mysql to check users and database :
mysql
MariaDB [(none)]> SELECT user,host,password FROM mysql.user;
MariaDB [(none)]> SHOW databases;

### Adminer

based on [Theo2lt inception readme](https://github.com/Theo2lt/Inception/tree/main) tutorial for testing `mariaDB` service.

port : 80

### docker compose

Services : `mariadb` and `adminer`.
Volume :  /home/jmouaike42/my_volume

### Makefile

`make`.

### Test mariadb-adminer pair

open in a browser http://jmouaike.42.fr

adminer login window :
```
mariadb
jmouaike42
************
wordpress
```