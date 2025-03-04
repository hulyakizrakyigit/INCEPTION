#!/bin/bash

MYSQL_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
MYSQL_PASSWORD=$(cat /run/secrets/db_password)

mysqld_safe --skip-networking &

sleep 5

mysql -u root --skip-password -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"
mysql -u root --skip-password -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mysql -u root --skip-password -e "GRANT ALL PRIVILEGES ON *.* TO '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mysql -u root --skip-password -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
mysql -u root --skip-password -e "FLUSH PRIVILEGES;"
mysql -u root --skip-password -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
mysqladmin -u root -p$MYSQL_ROOT_PASSWORD shutdown

exec mysqld_safe --bind-address=0.0.0.0