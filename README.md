# CentOS v7 with MariaDB v10
This image includes an RPM installation of MariaDB v10 from the MariaDB
repository.

In addition, I've added the hostname, and sysvinit-tools packages to provide
the ability for the DB instance to refer to its own hostname, and to use
pidof.

Securing the DB instance is performed using the packaged script
'mysql\_secure\_installation'. Anonymous connections, remote connections 
are both disabled by default, and the test DB removed.
