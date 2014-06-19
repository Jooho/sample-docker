#!/bin/bash

#Local IP
export IP=$(echo $(getent hosts docker-registry)|cut -d' ' -f1)


#Comment mod_proxy_balancer.so module to avoid conflict mod_cluster
export comment_module_line=$(cat -n  /home/jboss-ews-2.0/httpd/conf/httpd.conf|grep proxy_balancer_module|awk '{print $1}')
#echo $comment_module_line
#echo sed  -e  "${comment_module_line}s/LoadModule/#LoadModule/g" -i /etc/httpd/conf/httpd.conf
sed  -e  "${comment_module_line}s/LoadModule/#LoadModule/g" -i  /home/jboss-ews-2.0/httpd/conf/httpd.conf


#Add ServerName
echo "ServerName ws1.jhouse.co.kr" >> /home/jboss-ews-2.0/httpd/conf/httpd.conf
./.postinstall
#export EWS_HOME=`pwd`
#if [ ! -f /etc/pki/tls/certs/localhost.crt ] ; then
#cat << EOF | openssl req -new -key /etc/pki/tls/private/localhost.key \
#         -x509 -days 365 -set_serial $RANDOM \
#         -out /etc/pki/tls/certs/localhost.crt 2>/dev/null
#--
#SomeState
#SomeCity
#SomeOrganization
#SomeOrganizationalUnit
#${FQDN}
#root@${FQDN}
#EOF
#fi
#
#export LD_LIBRARY_PATH=$EWS_HOME/lib
#
#sed -i -e "s: modules/: $EWS_HOME/modules/:g" -e "s:/var/www:$EWS_HOME/www:g" -e "s:ServerRoot \"/etc/httpd\":ServerRoot \"$EWS_HOME\":"  $EWS_HOME/conf/httpd.conf

