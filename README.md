# inception-42

### Setup

#### Prerequisites

`Virtualbox manager` and `Vagrant` should be installed

#### Virtual machine 

Virtual machine was built with `Vagrant` based on `Vagrantfile`.

The command `vagrant up` will build the `VM`.

#### MariaDB-adminer pair

[](https://mariadb.com/kb/en/installing-and-using-mariadb-via-docker/)

#### Installing wordpress

##### wordpress-CLI 

    [](https://www.hostinger.fr/tutoriels/wp-cli)


### Evaluation

#### Explanations

How Docker and docker-compose work

`make ps` `docker ps` 

#### Docker compose
$ docker compose version
Docker Compose version v2.18.1
$ docker version
Client: Docker Engine - Community
 Version:           24.0.2
[ Compose file format versions](https://docs.docker.com/compose/compose-file/compose-file-v3/)

#### MariaDB

testmariadb:
`docker exec -ti mariadb bash`

check config :
cat /etc/mysql/mariadb.conf.d/50-server.cnf

[MariaDB doc](https://mariadb.com/kb/en/using-mariadb-server/)
[SQL statements](https://mariadb.com/kb/en/sql-statements/)
start mysql to check users and database :
`mysql
MariaDB [(none)]> SELECT user,host,password FROM mysql.user;
MariaDB [(none)]> SHOW databases; 
MariaDB [(none)]> USE wordpress;
MariaDB [wordpress]> SHOW TABLES;
MariaDB [wordpress]> SELECT * FROM wp_users;
SELECT ID, user_login, user_email FROM wp_users;
SHOW COLUMNS FROM wp_posts;
 SELECT ID, post_author, post_date, post_title  FROM wp_posts;

from mariadb container :
| connect as root
`mysql --user=root mysql`
`mysql -u root -p`

from wordpress container :

#### Wordpress database
[Wordpress database scheme](https://codex.wordpress.org/Database_Description)
[wordpress-database-schema](https://blogvault.net/wordpress-database-schema/)



#### 
wordpress login :
`https://jmouaike.42.fr/wp-login.php`
`https://jmouaike.42.fr/wp-admin/`
