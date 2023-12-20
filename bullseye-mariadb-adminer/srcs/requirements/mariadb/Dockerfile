FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y mariadb-server

# RUN mkdir -p /run/mysqld && \
#     mkdir -p /var/lib/mysql

# RUN chown -R mysql /var/lib/mysql && \
#     chmod 777 /var/lib/mysql

# COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/ 
COPY --chmod=0744 ./tools/mariadb.sql /usr/local/bin/
COPY --chmod=0755 ./tools/script.sh /usr/local/bin/

EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/script.sh"]

# RUN sed -i 's/127.0.0.1/0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf
# CMD ["mariadbd", "--user=mysql", "--bind-address=0.0.0.0"]
# CMD ["mysqld_safe"] 
# CMD ["mysqld", "--bind-address=0.0.0.0" ]