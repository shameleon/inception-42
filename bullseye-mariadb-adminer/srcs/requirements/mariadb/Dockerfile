FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y mariadb-server

COPY --chmod=0755 ./tools/script.sh /usr/local/bin/

EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/script.sh"]
