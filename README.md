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

I've added a script in the image that generates a privileged grant, and 
flushes DB privileges making it active immediately.  
The script attempts to retrive an IP from three variables. In order of
precedence, they are: $DBGRANTIP, $1 argument to grant.sh, and lastly, 
the ip of docker0.  
```
docker exec [container_name] /con/context/grant.sh [optional:ip]
```
Once the grant is complete, you will be able to connect to the service with
your favorite database administration tool on the NAT'd port assigned 
to your new container.

## TODO
* ~~condition check for grant.sh and provide status out~~
* ~~Build standard method to pass IP to grant.sh~~
* Organize MariaDB logging
* Add customizations to instance in my.cnf
* More when I think of it...
