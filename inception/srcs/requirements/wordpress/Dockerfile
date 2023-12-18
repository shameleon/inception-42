FROM debian:bullseye

RUN apt-get update -y && \
    apt-get install -y curl php php-fpm php-mysqli mariadb-client && \
    mkdir -p /run/php && \
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp && \
    wp cli update

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/

COPY /tools/entrypoint.sh /usr/local/bin

RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]