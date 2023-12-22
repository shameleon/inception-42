# Inception-42

## Subject

`Inception` project is about setting up and running a small infrastructure of services in order to have a functional `wordpress` website, with `nginx` as web-server and a database relying on `MariaDB` service. 
As it is forbidden to pull and use ready-made `docker images` from `DockerHub` for these services. The image for each of the given services (`nginx`, `wordpress`, `MariaDB`) has to be build from a `Dockerfile` solely based on the `image` of either `Alpine` or `Debian` (penultimate stable version). 
It is mandatory to be using `docker compose`, through a `Makefile` to coordinate the services, while building them and running them, and for maintaing a user-defined network between these services.
It is also mandatory to use an `.env` file for `docker compose`.

---

### Services

• A Docker container that contains NGINX with TLSv1.2 or TLSv1.3 only.
• A Docker container that contains WordPress + php-fpm (it must be installed and
configured) only without nginx.
• A Docker container that contains MariaDB only without nginx.

### Volumes and Network

• A volume that contains your WordPress database.
• A second volume that contains your WordPress website files.

• A docker-network that establishes the connection between your containers.

```
Nginx     <-- port 443 TLS --> web browsing 
Nginx     <-- port 9000    --> Wordpress
Wordpress <-- port 3306    --> MariaDB
```

### Forbidden
- Pulling `DockerHub` images other than `alpine` or `debian`.
- In `docker-compose.yml` : `network: host` or `--link` or `links:`.

---

## Installation

### Virtual machine (VM)

In order to have a isolated, secure and reproducible environment both for developping and running, I chose `Vagrant`. Virtual machine was built with `Vagrant` based on `Vagrantfile`.

#### Prerequisites

`Virtualbox manager` and `Vagrant` should be installed ON 42's workstation. Otherwise, they are needed.

#### Vagrantfile

Vagrantfile based on [Vagrant to jumpstart your development into 42 project : Inception ](https://github.com/hel-kame/inception_vagrant.git). Docker will be installed and user will be in `sudo` and `docker` groups.

Some `Vagrantfile` changes with my username and to add `VScode`.

```sudo snap install code --classic```


#### vagrant up

Place the Vagrantfile in a dedicated directory on `sgoinfre`.
Then from thisdirectory, type the command `vagrant up`. That will build the `VM`.

Default password is `vagrant`.

#### VM setups

Change docker permissions to run `docker` command without `sudo`

```shell
# to run docker command without sudo :
chmod 777 /var/run/docker.sock
ls -l /var/run/docker.sock
```

- Github settings 

```shell
git config --global user.email "####"
git config --global user.name "####"
ssh-keygen -t ed25519  -C "####@###.com"
cat home/####42/.ssh/id_ed25519.pub
# copy and add the public key to github account settings/SSH
# test github :
eval "$(ssh-agent -s)"
ssh -T git@github.com
```

- Setup `Domain Name System` (DNS)

`make` command will execute the bash script `./srcs/requirements/tools/setup.sh ` that will be changing `/etc/hosts` file :
```127.0.0.1 localhost``` to domain name ```127.0.0.1 jmouaike.42.fr www.jmouaike.42.fr```.

`make prune` command will revert  `/etc/hosts` file to ```127.0.0.1 localhost```

---

### Usage

---


From the `VM`, `git clone` the repo `inception-42`.

#### .env file : environment variables

An `.env` file should be present in `requirements` directory since it is needed by `docker compose`.

Here is a model for `.env` file :

```hack
# docker-compose environment file
DOMAIN_NAME=jmouaike.42.fr

WP_PATH=/var/www/html/wordpress

WP_TITLE=Inception

WP_ADMIN=
WP_ADMIN_PASSWORD=
WP_ADMIN_EMAIL=
WP_USER=
WP_USER_PASSWORD=
WP_USER_EMAIL=

DB_HOST=mariadb
DB_TABLE_PREFIX=wp_
DB_SERVER=MariaDB
DB_USER=
DB_USER_PASSWORD=
DB_ROOT_PASSWORD=
DB_DATABASE=wordpress
```

[Best practices for working with environment variables in Docker Compose](https://docs.docker.com/compose/environment-variables/best-practices/)

[Best  Practices when using Docker Compose](https://hackmamba.io/blog/2022/09/best-practices-when-using-docker-compose/)

[Use secrets](https://docs.docker.com/compose/use-secrets/)

#### Launch the Make

`cd inception & make` will build and run the infrastrure of services.

Provided `/etc/hosts` changes above were made, the website should be pointing to `https://jmouaike.42.fr/` or  `https://www.jmouaike.42.fr/`.

---

## Useful links and reading

### Docker

Many `docker` and `docker compose` ressources are available.

[Docker docs](https://docs.docker.com/)

[Docker Compose overview](https://docs.docker.com/compose/)

#### Docker compose
$ docker compose version
Docker Compose version v2.18.1
$ docker version
Client: Docker Engine - Community
 Version:           24.0.2
[ Compose file format versions](https://docs.docker.com/compose/compose-file/compose-file-v3/)

#### Docker images

The `debian:bullseye` is the penultimate version for Debian. `debian:bookworm` being the latest stable.

```dockerfile
FROM debian:bullseye
```

### Services configuration

#### MariaDB

[Installing-and-using-mariadb](https://mariadb.com/kb/en/installing-and-using-mariadb-via-docker/)


To avoid `root`` login without password
To change root MySQL/MariaDB password :

[Alter root password ](https://dev.mysql.com/doc/refman/8.0/en/alter-user.html)
`ALTER USER root@localhost IDENTIFIED BY PASSWORD '************';`

[how-to-reset-root-mysql-mariadb-password ](https://linuxconfig.org/how-to-reset-root-mysql-mariadb-password-on-ubuntu-20-04-focal-fossa-linux)

forcing a TCP connection
`mysql -h 172.17.0.2 -P 3306 --protocol=TCP -u root -p`

#### Nginx

[Creating NGINX Plus and NGINX Configuration Files](https://docs.nginx.com/nginx/admin-guide/basic-functionality/managing-configuration-files/)

[Examples of NGINX configuration for WordPress](https://www.nginx.com/resources/wiki/start/topics/recipes/wordpress/)

#### wordpress-CLI 

[WP-CLI Commands](https://developer.wordpress.org/cli/commands/)

[wp-CLI](https://www.hostinger.fr/tutoriels/wp-cli)

#### wp-config.php file

Wordpress `wp-config.php` is in `/var/www/html/wordpress/` directory and is setup

[Le fichier wp-config.php de WordPress : Optimisation, sécurité ](https://www.wpserveur.net/fichier-wp-config-wordpress/)

[wp-config file](https://themes.artbees.net/blog/configuring-wordpress-in-wpconfig-php-file/)

#### To go further

[Best practice secure NGINX configuration for WordPress](https://www.getpagespeed.com/server-setup/nginx/best-practice-secure-nginx-configuration-for-wordpress#)

[why you should protect you wp-config file ](https://medium.com/stolabs/why-should-you-protect-your-wp-config-php-file-d1d1e6c0d6e6)

Add the following line to nginx configuration file 
`location ~* wp-config.php { deny all; }`

[Harden Wordpress security](https://gist.github.com/nfsarmento/57db5abba08b315b67f174cd178bea88)

[10 Nginx Rules to Harden WordPress Security](https://www.hongkiat.com/blog/nginx-rules-for-wordpress-security/)

---

## Evaluation

---

### Explanations

- How Docker and docker-compose work.

- The difference between a Docker image used with docker-compose and without docker-compose.

- The benefit of Docker compared to VMs.

- The pertinence of the directory structure required for this project.


### Test inception services

#### make

Before the `make` command to build and run the project set of services, be sure to remove any leftovers :

```shell
docker stop $(docker ps -qa) & docker rm $(docker ps -qa) & docker rmi -f $(docker images -qa) & docker volume rm $(docker volume ls -q)
```

`make` command to build and run the project. the service should be running

`make ps` is `docker ps` 

### MariaDB

testmariadb:
`docker exec -ti mariadb bash`

check config :
cat /etc/mysql/mariadb.conf.d/50-server.cnf

[MariaDB doc](https://mariadb.com/kb/en/using-mariadb-server/)
[SQL statements](https://mariadb.com/kb/en/sql-statements/)
start mysql to check users and database :
```sql
$ mysql
MariaDB [(none)]> SELECT user,host,password FROM mysql.user;
MariaDB [(none)]> SHOW databases; 
MariaDB [(none)]> USE wordpress;
MariaDB [wordpress]> SHOW TABLES;
MariaDB [wordpress]> SELECT * FROM wp_users;
SELECT ID, user_login, user_email FROM wp_users;
SHOW COLUMNS FROM wp_posts;
SELECT ID, post_author, post_date, post_title  FROM wp_posts;
```

From mariadb container, connect as root without password `mysql --user=root mysql` or `mysql -u root -p` should ask password. 

`mysql -u root -p${DB_ROOT_PASSWORD}`         OK

`mysql -u ${DB_USER} -p${DB_USER_PASSWORD}`   OK

`SHOW GRANTS FOR 'root'@'localhost';`

---
