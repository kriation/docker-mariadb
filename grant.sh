#!/bin/bash

# Builds grant for root from docker0
/usr/bin/mysql -u root --password=toor \
    -S /con/data/mysql/mysql.sock mysql \
    -e "grant all on *.* to root@`ip route list | \
	awk '{if(NR==1) print $3}'` identified by 'toor';"

# Self-explanatory
/usr/bin/mysqladmin -u root --password=toor \
    -S /con/data/mysql/mysql.sock \
    flush-privileges

