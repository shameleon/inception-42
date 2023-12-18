FROM debian:buster
RUN apt-get update && \
    apt-get install -y \
    php7.3-mysql \
    php7.3-fpm \
    curl \ 
    mariadb-client && \
    apt-get clean && \
    apt-get --yes --quiet autoremove --purge && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/php

COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp && \
    wp cli update

EXPOSE 9000

COPY /tools/entrypoint.sh /usr/local/bin

RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]