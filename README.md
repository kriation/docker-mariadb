# CentOS v7 with MariaDB v10
This image includes an RPM installation of MariaDB v10 from the MariaDB
repository.

In addition, I've added the hostname, and sysvinit-tools packages to provide
the ability for the DB instance to refer to its own hostname, and to use
pidof.

Securing the DB instance is performed using the packaged script
'mysql_secure_installation'. Anonymous connections, remote connections 
are both disabled by default, and the test DB removed.

## Credentials
The all privilege user in the DB is **root**  
The credential is set to **toor**

Do **NOT** go to production with this image and the above default set.

## Usage
I designed the image to be self-sufficient at runtime requiring little
additional configuration once started.

Starting a fresh container (with NAT) only requires the following:  
```
docker run -P kriation/centos7-mariadb10
```

To enable network access from docker0, I've added a grant script in the 
image that generates the grant, and flushes privilegs making it active
immediately.  
```
docker exec [container_name] /con/context/grant.sh
```

Once the grant is complete, you will be able to connect to the service with
your favorite database administration tool on the NAT'd port assigned by
Docker to your new container.

## TODO
* Condition check for grant.sh and provide status out
* Build standard method to pass IP to grant.sh
* Organize MariaDB logging
* Add customizations to instance in my.cnf
* More when I think of it...
