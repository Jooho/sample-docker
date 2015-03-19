#!/bin/bash

#Local IP
export IP=$(echo $(getent hosts docker-registry)|cut -d' ' -f1)


#Comment mod_proxy_balancer.so module to avoid conflict mod_cluster
export comment_module_line=$(cat -n  $EWS_HOME/httpd/conf/httpd.conf|grep proxy_balancer_module|awk '{print $1}')
sed  -e  "${comment_module_line}s/LoadModule/#LoadModule/g" -i  $EWS_HOME/httpd/conf/httpd.conf

#Add ServerName
echo "ServerName ws1.jhouse.co.kr" >> $EWS_HOME/httpd/conf/httpd.conf
./.postinstall
mv $EWS_HOME/httpd/conf.d/mod_cluster.conf $EWS_HOME/httpd/conf.d/mod_cluster.conf.ori
rm $EWS_HOME/httpd/conf.d/auth_kerb.conf

