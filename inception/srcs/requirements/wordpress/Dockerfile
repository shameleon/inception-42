FROM debian:buster
RUN apt-get update && \
    apt-get install -y php7.3-mysqli php7.3-fpm \
    curl mariadb-client && \
    rm -rf /var/lib/apt/lists/*
RUN mkdir -p /run/php
# To allow external connections
COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/
# COPY ./conf/wp-config.php /var/www/html/
# ADD https://wordpress.org/latest.tar.gz /var/www/html/latest.tar.gz
# RUN cd /var/www/html && \
# 	tar -xvf latest.tar.gz && \
# 	rm -rf latest.tar.gz && \
#   chown -R www-data /var/www/html/wordpress && \
#   chmod -R 777 /var/www/
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp
EXPOSE 9000
COPY /tools/entrypoint.sh /usr/local/bin
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]