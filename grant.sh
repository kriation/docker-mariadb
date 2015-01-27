#!/bin/bash

# IP Valiation
validate_ip()
{
    IFS=.
    set -- $1
    [ $# -ne 4 ] && return 65
    for octet
	do
	    [ $octet -ge 255 ] && return 65
	done

    IP="$*"
    return 0
}

# Order of precedence
if [ -n "$DBGRANTIP" ]
then
	validate_ip $DBGRANTIP
elif [ -n "$1" ]
then
	validate_ip $1
else
    IP=`ip route list | awk '{if(NR==1) print $3}'`

fi

echo "Setting grant for root from $IP"

/usr/bin/mysql -u root --password=toor \
        -S /con/data/mysql/mysql.sock mysql \
        -e "grant all on *.* to root@$IP identified by 'toor';"

#### Self-explanatory
/usr/bin/mysqladmin -u root --password=toor \
        -S /con/data/mysql/mysql.sock \
        flush-privileges
