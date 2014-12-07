FROM centos:centos7

MAINTAINER Armen Kaleshian <armen@kriation.com>

# Copy repo file
COPY mariadb.repo /etc/yum.repos.d/

# Install MariaDB Server
RUN yum -y install MariaDB-server hostname sysvinit-tools && \
    yum -y clean all

# Secure the MariaDB Server
RUN /etc/init.d/mysql start && \ 
    echo -e "\nn\nY\nY\nY\nY\n" | /usr/bin/mysql_secure_installation

# TODO
# Export volume, port, and tidy up for easy linking
