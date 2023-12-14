FROM debian:buster

RUN apt-get update && \
    apt install -y mariadb-server 
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY ./tools/script.sh /
RUN chmod +x /script.sh
EXPOSE 3306
# CMD [ "/script.sh" ]
ENTRYPOINT ["/script.sh" ]