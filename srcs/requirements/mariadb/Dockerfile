FROM debian:buster

RUN apt-get update && apt-get install -y mariadb-server

EXPOSE 3306

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY ./tools /var/

RUN chmod +x /var/mariadb.sh

ENTRYPOINT ["/var/mariadb.sh"]
