#!/bin/bash

#Add user & Change password => user : jboss, password : !qaz2wsx
export username='jboss'
export as_is_passwd=$(cat -n $HOME_PATH/$EAP_PKG/domain/configuration/host-slave.xml |grep secret|awk '{print $3}'|cut -d\" -f2)
export to_be_passwd='IXFhejJ3c3g='

echo ${as_is}
sed -e "s/$as_is_passwd/$to_be_passwd/g" -i  $HOME_PATH/$EAP_PKG/domain/configuration/host-slave.xml

export add_username='jboss'
export user_line_no=$(cat -n $HOME_PATH/$EAP_PKG/domain/configuration/host-slave.xml|grep -i 'remote host'|awk '{print $1}')

echo sed -e "${user_line_no}s/remote/${username}/g" $HOME_PATH/$EAP_PKG/domain/configuration/host-slave.xml
sed -e "${user_line_no}s/remote/remote username='${username}'/g" -i $HOME_PATH/$EAP_PKG/domain/configuration/host-slave.xml

#To avoid Hornetq cluster issue, do not start other-server-group
sed  -e  "s/group=\"other-server-group\"/group=\"other-server-group\" auto-start=\"false\"/g" -i   $HOME_PATH/$EAP_PKG/domain/configuration/host-slave.xml

#In order to do failover test, use ha profile by default
sed  -e  "s/name=\"main-server-group\" profile=\"full\"/name=\"main-server-group\" profile=\"ha\"/g" -i   $HOME_PATH/$EAP_PKG/domain/configuration/domain.xml
sed  -e  "s/socket-binding-group ref=\"full-sockets\"/socket-binding-group ref=\"ha-sockets\"/g" -i   $HOME_PATH/$EAP_PKG/domain/configuration/domain.xml

#Insert instance-id into web subsystem
sed -e "s/default-virtual-server=\"default-host\"/default-virtual-server=\"default-host\" instance-id=\"\${jboss.node.name}\" /g" -i  $HOME_PATH/$EAP_PKG/domain/configuration/domain.xml
sed -e "s/default-virtual-server=\"default-host\"/default-virtual-server=\"default-host\" instance-id=\"\${jboss.node.name}\" /g" -i  $HOME_PATH/$EAP_PKG/standalone/configuration/standalone-ha.xml

#Change UDP to TCP on mod_cluster
sed -e "s/advertise-socket=\"modcluster\"/advertise-socket=\"modcluster\"  proxy-list=\"apache:6666\"  advertise=\"false\" /g" -i $HOME_PATH/$EAP_PKG/domain/configuration/domain.xml
sed -e "s/advertise-socket=\"modcluster\"/advertise-socket=\"modcluster\"  proxy-list=\"apache:6666\"  advertise=\"false\" /g" -i $HOME_PATH/$EAP_PKG/standalone/configuration/standalone-ha.xml

#Uncomment PermitRootLogin
sed  -e  "s/#PermitRootLogin/PermitRootLogin/g" -i /etc/ssh/sshd_config


