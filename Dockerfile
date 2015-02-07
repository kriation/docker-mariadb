FROM kriation/centos7

MAINTAINER Armen Kaleshian <armen@kriation.com>

# Copy repo file
COPY mariadb.repo /etc/yum.repos.d/

# Copy grant script
COPY grant.sh /con/context/

# Install MariaDB Server and supporting packages
RUN yum -y install MariaDB-server hostname sysvinit-tools && \
    yum -y clean all

# Secure the MariaDB Server
RUN chmod u+x /con/context/grant.sh && \
    chown mysql:mysql /etc/my.cnf && \
    chown -R mysql:mysql /etc/my.cnf.d && \
    /etc/init.d/mysql start && \ 
    echo -e "\nY\ntoor\ntoor\nY\nY\nY\nY\n" | \
    /usr/bin/mysql_secure_installation && \
    /etc/init.d/mysql stop && \
    # Migrate and expose
    chown -R mysql:mysql /con && \
    mv /var/lib/mysql/* /con/data/. && \
    mv /etc/my.cnf /con/configuration/. && \
    mv /etc/my.cnf.d /con/configuration/. && \
    sed -i 's/etc/con\/configuration/' /con/configuration/my.cnf 

EXPOSE 3306

ENTRYPOINT ["/usr/sbin/mysqld", \
	    "--defaults-extra-file=/con/configuration/my.cnf", \
	    "--datadir=/con/data", \
	    "--socket=/con/data/mysql.sock", \
	    "--user=mysql"]
