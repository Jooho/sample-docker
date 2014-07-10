#!/bin/bash
. ./docker-env.sh
#Setting Basic information 
echo Updating docker basic information
##Uncomment PermitRootLogin
sed  -e  "s/#PermitRootLogin/PermitRootLogin/g" -i /etc/ssh/sshd_config

##Change IP/HOSTNAME in docker-env.sh
NEW_HOST_NAME=$(hostname)
OLD_HOST_NAME=$(grep HOST_NAME docker-env.sh |cut -d= -f2)
if [[ $OLD_HOST_NAME != *$NEW_HOST_NAME* ]]; then
	HOST_NAME_LINE=$(cat -n docker-env.sh | grep HOST_NAME |awk '{print $1}')
	sed  -e  "${HOST_NAME_LINE}s/${OLD_HOST_NAME}/\"${NEW_HOST_NAME}\"/g" -i  ./docker-env.sh
fi

export NEW_IP=$(ifconfig eth0|grep 'inet addr'|cut -d: -f2|awk '{print $1}')
export OLD_IP=$(grep IP  docker-env.sh |cut -d= -f2)
if [[ $OLD_IP != *$NEW_IP* ]]; then
	export IP_LINE=$(cat -n docker-env.sh | grep IP |awk '{print $1}')
	sed  -e  "${IP_LINE}s/${OLD_IP}/\"${NEW_IP}\"/g" -i  ./docker-env.sh
fi


. ./docker-env.sh

# Set my sql configuration
# http://www.linuxhomenetworking.com/wiki/index.php/Quick_HOWTO_:_Ch34_:_Basic_MySQL_Configuration#.U60ZepV7nWQ
## Set bind-address for mysql server
mv /etc/my.cnf /etc/my.cnf.ori
export mysql_start_line=$(cat -n /etc/my.cnf.ori |egrep  "mysqld]$" |awk '{print $1}')
sed -e "$(($mysql_start_line+1))ibind-address=${IP}" /etc/my.cnf.ori >/etc/my.cnf


## Register mysql to service
$(chkconfig mysqld on)
#$(service mysqld start)
#$(mysqladmin -u root password redhat)
#$(mysql -u root -p ./mysql_conf.sql)
 
if [ ! -f /var/lib/mysql/ibdata1 ]; then

    mysql_install_db

    /usr/bin/mysqld_safe &
    sleep 10s
    echo "use mysql;"|mysql
    echo "select host, user from user;" |mysql
    echo "create database jhousedb;"|mysql
    echo "grant select on jhousedb.* to jhouse@172.17.42.1 identified by 'redhat';" |mysql
    echo "FLUSH PRIVILEGES;" | mysql
    echo "GRANT ALL PRIVILEGES ON *.* TO 'jhouse'@'172.17.42.1' WITH GRANT OPTION;" | mysql
    echo "FLUSH PRIVILEGES;" | mysql
    killall mysqld
    sleep 10s
fi

#/usr/bin/mysqld_safe
service sshd start
service mysqld start
#/usr/bin/mysqld_safe

#Create sample table(example) |  Import sample data
$(mysql < test_data.sql)
