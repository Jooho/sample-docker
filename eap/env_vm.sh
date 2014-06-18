#!/bin/bash

#Add user & Change password => user : jboss, password : !qaz2wsx
export username='jboss'
export as_is_passwd=$(cat -n ./host-slave.xml |grep secret|awk '{print $3}'|cut -d\" -f2)
export to_be_passwd='IXFhejJ3c3g='

echo ${as_is}
sed -e "s/$as_is_passwd/$to_be_passwd/g" -i  /home/wildfly-8.1.0.CR2/domain/configuration/host-slave.xml

export add_username='jboss'
export user_line_no=$(cat -n ./host-slave.xml|grep -i 'remote host'|awk '{print $1}')

echo sed -e "${user_line_no}s/remote/${username}/g" host-slave.xml
sed -e "${user_line_no}s/remote/remote username='${username}'/g" -i host-slave.xml


#Uncomment PermitRootLogin
sed  -e  "s/#PermitRootLogin/PermitRootLogin/g" -i /etc/ssh/sshd_config
