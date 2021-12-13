# MariaDB on CentOS v7
This image includes an RPM installation of MariaDB from the MariaDB
repository.

Securing the DB instance is performed using the packaged script
`mariadb_secure_installation`. Anonymous connections, remote connections
are both disabled by default, and the test DB removed.

## Usage
Starting a fresh container (with NAT) only requires the following:  
```
docker run -P kriation/centos7-mariadb
```
