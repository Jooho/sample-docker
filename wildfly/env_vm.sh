#!/bin/bash

#Add user & Change password => user : jboss, password : !qaz2wsx
export username='jboss'
export as_is_passwd=$(cat -n /home/wildfly-8.1.0.Final/domain/configuration/host-slave.xml |grep secret|awk '{print $3}'|cut -d\" -f2)
export to_be_passwd='IXFhejJ3c3g='

echo ${as_is}
sed -e "s/$as_is_passwd/$to_be_passwd/g" -i  /home/wildfly-8.1.0.Final/domain/configuration/host-slave.xml

export add_username='jboss'
export user_line_no=$(cat -n /home/wildfly-8.1.0.Final/domain/configuration/host-slave.xml|grep -i 'remote host'|awk '{print $1}')

echo sed -e "${user_line_no}s/remote/${username}/g" /home/wildfly-8.1.0.Final/domain/configuration/host-slave.xml
sed -e "${user_line_no}s/remote/remote username='${username}'/g" -i /home/wildfly-8.1.0.Final/domain/configuration/host-slave.xml

#To avoid Hornetq cluster issue, do not start other-server-group
sed  -e  "s/group=\"other-server-group\"/group=\"other-server-group\" auto-start=\"false\"/g" -i   /home/wildfly-8.1.0.Final/domain/configuration/host-slave.xml

#In order to do failover test, use ha profile by default
sed  -e  "s/name=\"main-server-group\" profile=\"full\"/name=\"main-server-group\" profile=\"ha\"/g" -i   /home/wildfly-8.1.0.Final/domain/configuration/domain.xml
sed  -e  "s/socket-binding-group ref=\"full-sockets\"/socket-binding-group ref=\"ha-sockets\"/g" -i   /home/wildfly-8.1.0.Final/domain/configuration/domain.xml

#Uncomment PermitRootLogin
sed  -e  "s/#PermitRootLogin/PermitRootLogin/g" -i /etc/ssh/sshd_config
