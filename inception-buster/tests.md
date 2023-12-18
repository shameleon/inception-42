# tests for inception
wget -k https://jmouaike.42.fr --no-check-certificate

## config

### nginx

ping wordpress                  OK
ping mariadb                    failure


/run/nginx.pid                   1
/var/www/html/*                  <-> wp_ files
/etc/nginx/conf.d/                          empty
/etc/nginx/sites-available/                 default
/etc/nginx/sites-enabled/                   empty

/etc/nginx/snippets/self-signed.conf        .crt .key
/etc/nginx/dhparams.pem

/etc/ssl/certs/nginx-selfsigned.crt;
/etc/ssl/private/nginx-selfsigned.key;

/etc/ssl/openssl.cnf                man

[ssl_stapling](https://superuser.com/questions/1447652/nginx-warn-ssl-stapling-ignored-issuer-certificate-not-found-for-certifica)

nginx -c /etc/nginx/nginx.conf -t
    nginx: [warn] "ssl_stapling" ignored, issuer certificate not found for certificate "/etc/ssl/certs/nginx-selfsigned.crt"

    include /etc/nginx/modules-enabled/*.conf;

	include /etc/nginx/conf.d/*.conf;
	include /etc/nginx/sites-enabled/*;

- COPY ./conf/default /etc/nginx/sites-enabled/default
- COPY ./conf/default /etc/nginx/sites-available/
COPY ./conf/nginx.conf /etc/nginx/conf.d

etc/hosts
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿ ⣿⠀⣿⠀⠀

https://www.howtoforge.com/tutorial/dockerizing-wordpress-with-nginx-and-php-fpm/

### wordpress
apt update && apt install -y iputils-ping
ping nginx
ping mariadb


docker compose -f ./srcs/docker-compose.yml logs wordpress

#### 
[wp-cli](https://wp-cli.org/) 

ẁp --info should work 
same as php wp-cli.phar --info

[wp-config](https://codex.wordpress.org/fr:Modifier_wp-config.php)
[wp-cli commands](https://developer.wordpress.org/cli/commands/core/)


RUN apt update; \
	apt install -y php7.3 php-mysqli php-fpm mariadb-client curl sendmail
RUN apt-get -yqq install -y php-fpm php-mysql default-mysql-client php-pear php-dev curl;

COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d
COPY ./conf /var/www/


 /run/php/

 chown -R www-data /var/www/wordpress
chmod -R 775 /var/www/wordpress
cd /var/www/wordpress
wp core download --allow-root
mv /var/www/wp-config.php /var/www/wordpress/


/var/www/html/wp-config.php

define( 'WP_ALLOW_REPAIR', true );
define('WP_CACHE', true);
## 

[](https://www.linkedin.com/pulse/fixing-issues-ping-from-docker-nginx-container-mohammad-akif)
sudo docker exec -it nginx bash
apt-get update
apt-get install inetutils-ping -y

docker exec -it nginx ping wordpress


### 

if deamon error
sudo service docker stop
sudo service docker start

[](https://devtidbits.com/2019/11/02/customise-wordpress-on-docker/)