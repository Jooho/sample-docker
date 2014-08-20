FROM ljhiyh/centos65
MAINTAINER Jooho Lee,Jay <ljhiyh@gmail.com>
ADD epel-release-6-8.noarch.rpm /etc/yum.repos.d/
RUN rpm -ivh /etc/yum.repos.d/epel-release-6-8.noarch.rpm
RUN yum install -y openssh-server
RUN yum install -y openssh-clients
RUN yum install -y httpd
RUN yum install -y supervisor
ADD supervisord.conf /home/supervisord.conf
RUN cat /home/supervisord.conf > /etc/supervisord.conf
RUN mkdir -p /home/apache/docs/ws1
RUN mkdir -p /home/apache/docs/ws2
RUN mkdir -p /home/apache/docs/ws3
RUN mkdir -p /home/apache/tmp
RUN echo 'root:redhat' | chpasswd
ADD bashrc /home/apache/tmp/bashrc
RUN cat /home/apache/tmp/bashrc >> /etc/profile
ADD env_vm.sh /home/env_vm.sh
RUN . ./home/env_vm.sh 
ADD apache_conf.tar /etc/httpd/conf.d/
ADD mod_cluster.tar /etc/httpd/modules/
EXPOSE 22 80 6666
CMD ["/usr/bin/supervisord"]
