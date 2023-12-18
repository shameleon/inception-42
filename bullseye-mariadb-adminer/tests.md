[Theo2lt inception readme](https://github.com/Theo2lt/Inception/tree/main)

### Test MariaDB
test_maria:
	cd $(WORK_DIR)
	docker build -t my-mariadb ./srcs/requirements/mariadb/
	docker run -tid --name testmariadb --env-file .env my-mariadb

testmariadb:
	docker exec -ti testmariadb bash

check env :
env

check config :
cat /etc/mysql/mariadb.conf.d/50-server.cnf

start mysql to check users and database :
mysql
MariaDB [(none)]> SELECT user,host,password FROM mysql.user;
MariaDB [(none)]> SHOW databases;

### docker-compose

mkdir /home/jmouaike42/my_volume

make

http://jmouaike.42.fr

MariaDB
user
safepwd
wordpress