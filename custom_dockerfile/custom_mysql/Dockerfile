FROM mysql:8

LABEL maintainer="your_metadata"

# Custom MySQL configuration
COPY config/my.cnf /etc/mysql/conf.d/

# Initialization script (executed on first container start)
COPY init/init.sql /docker-entrypoint-initdb.d/
