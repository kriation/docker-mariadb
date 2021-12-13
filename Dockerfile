FROM kriation/centos7 as mariadb-config
ARG MARIADB_VERSION=mariadb-10.6

# Add MariaDB repository through script
RUN curl -sS https://downloads.mariadb.com/MariaDB/mariadb_repo_setup \
    | /bin/bash -s -- --mariadb-server-version="$MARIADB_VERSION" \
    --os-type='rhel' \
    --os-version='7'

# Install MariaDB Server and supporting packages
RUN yum -y install MariaDB-server && \
    yum -y clean all

# Secure the MariaDB Server
# Prompts for mariadb-secure-installation are the following:
# Use existing root password - <enter>
# Switch to unix_socket authentication - Yes
# Change the root password - No
# Remove anonymous users - Yes
# Disallow root login remotely - Yes
# Remove test database and access to it - Yes
# Reload privilege tables - Yes
RUN chown mysql:mysql /etc/my.cnf && \
    chown -R mysql:mysql /etc/my.cnf.d /var/lib/mysql && \
    /usr/share/mysql/mysql.server start && \
    echo -e "\nY\nn\nY\nY\nY\nY\n" | \
    /usr/bin/mariadb-secure-installation && \
    /usr/share/mysql/mysql.server stop

EXPOSE 3306

ENTRYPOINT ["/usr/sbin/mysqld", "--user=mysql"]

FROM mariadb-config
ARG BUILD_DATE
ARG MARIADB_VERSION=mariadb-10.6
LABEL maintainer="armen@kriation.com" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.build-date="$BUILD_DATE" \
      org.label-schema.license="GPLv2" \
      org.label-schema.name="MariaDB on CentOS v7" \
      org.label-schema.version="$MARIADB_VERSION" \
      org.label-schema.vendor="armen@kriation.com" \
      org.opencontainers.image.created="$BUILD_DATE" \
      org.opencontainers.image.licenses="GPL-2.0-only" \
      org.opencontainers.image.title="MariaDB on CentOS v7" \
      org.opencontainers.image.version="$MARIADB_VERSION" \
      org.opencontainers.image.vendor="armen@kriation.com"
