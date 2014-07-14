FROM docker-registry:5000/rhel65-base
ADD rhel.repo  /etc/yum.repo.d/
ADD epel-release-6-8.noarch.rpm /etc/yum.repos.d/
RUN rpm -ivh /etc/yum.repos.d/epel-release-6-8.noarch.rpm
RUN yum install -y openssh-server
RUN yum install -y openssh-clients
RUN yum install -y unzip
RUN yum install -y httpd
RUN yum install -y supervisor
ADD jboss-ews-httpd-2.0.0-RHEL6-x86_64.zip /home/
RUN unzip -q /home/jboss-ews-httpd-2.0.0-RHEL6-x86_64.zip -d /home/
RUN mkdir -p /home/apache/docs/ws1
RUN mkdir -p /home/apache/docs/ws2
RUN mkdir -p /home/apache/docs/ws3
RUN mkdir -p /home/apache/tmp
RUN echo 'root:redhat' | chpasswd
ADD bashrc /home/apache/tmp/bashrc
RUN cat /home/apache/tmp/bashrc >> /etc/profile
ADD supervisord.conf /home/supervisord.conf
RUN cat /home/supervisord.conf > /etc/supervisord.conf
ADD env_vm.sh /home/jboss-ews-2.0/httpd/
WORKDIR /home/jboss-ews-2.0/httpd
RUN . /home/jboss-ews-2.0/httpd/env_vm.sh 
ADD apache_conf.tar  /home/jboss-ews-2.0/httpd/conf.d/
ADD mod_cluster.tar /home/jboss-ews-2.0/httpd/modules/
ADD start_ews.sh /home/jboss-ews-2.0/httpd/
EXPOSE 22 80 6666
CMD ["/usr/bin/supervisord"]
