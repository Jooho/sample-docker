#!/bin/bash
#Local IP
export IP=$(echo $(getent hosts docker-registry)|cut -d' ' -f1)

#Comment mod_proxy_balancer.so module to avoid conflict mod_cluster
export comment_module_line=$(cat -n /etc/httpd/conf/httpd.conf|grep proxy_balancer_module|awk '{print $1}')
#echo $comment_module_line
#echo sed  -e  "${comment_module_line}s/LoadModule/#LoadModule/g" -i /etc/httpd/conf/httpd.conf
sed  -e  "${comment_module_line}s/LoadModule/#LoadModule/g" -i /etc/httpd/conf/httpd.conf


#Add ServerName
echo "ServerName ws1.jhouse.co.kr" >>/etc/httpd/conf/httpd.conf
