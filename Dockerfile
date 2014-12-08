FROM centos:centos7

MAINTAINER Armen Kaleshian <armen@kriation.com>

ENV DB_ROOTPW toor

# Copy repo file
COPY mariadb.repo /etc/yum.repos.d/

# Install MariaDB Server and supporting packages
RUN yum -y install MariaDB-server hostname sysvinit-tools && \
    yum -y clean all

# Secure the MariaDB Server
RUN /etc/init.d/mysql start && \ 
    echo -e "\nY\n${DB_ROOTPW}\n${DB_ROOTPW}\nY\nY\nY\nY\n" | \
    /usr/bin/mysql_secure_installation && \
    /etc/init.d/mysql stop

EXPOSE 3306

USER mysql

CMD ["/usr/sbin/mysqld"]
