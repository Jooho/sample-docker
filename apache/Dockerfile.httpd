FROM docker-registry:5000/centos65:basic
RUN yum install -y openssh-server
RUN yum install -y httpd
RUN mkdir -p /home/apache/docs/ws1
RUN mkdir -p /home/apache/docs/ws2
RUN mkdir -p /home/apache/docs/ws3
RUN mkdir -p /home/apache/tmp
RUN echo 'root:redhat' | chpasswd
ADD apache_conf.tar /etc/httpd/conf.d/
ADD mod_cluster.tar /etc/httpd/modules
RUN tar -xvf /etc/httpd/conf.d/apache_conf.tar 
RUN tar -xvf /etc/httpd/conf.d/mod_cluster.tar 
EXPOSE 22,80,6666
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD ["/usr/bin/supervisord"]
