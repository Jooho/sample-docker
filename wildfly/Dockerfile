FROM ljhiyh/centos65
MAINTAINER Jooho Lee,Jay <ljhiyh@gmail.com>
ADD epel-release-6-8.noarch.rpm /etc/yum.repos.d/
RUN rpm -ivh /etc/yum.repos.d/epel-release-6-8.noarch.rpm
RUN yum update -y
RUN yum install -y java-1.7.0-openjdk
RUN yum install -y unzip
RUN yum install -y openssh-server 
RUN yum install -y openssh-clients
RUN yum install -y supervisor
ADD supervisord.conf /home/supervisord.conf
RUN cat /home/supervisord.conf > /etc/supervisord.conf
ADD bashrc  /home/bashrc
RUN cat /home/bashrc >> /etc/profile
RUN echo 'root:redhat' | chpasswd
ADD wildfly-8.1.0.Final.zip /home/
RUN unzip -q /home/wildfly-8.1.0.Final.zip -d /home
ADD scripts.tar /home/wildfly-8.1.0.Final
ADD env_vm.sh /home/
RUN /home/env_vm.sh 
WORKDIR /home/wildfly-8.1.0.Final
RUN bin/add-user.sh -s jboss !qaz2wsx
USER root
WORKDIR /home
EXPOSE 22 8080 9990 9999
CMD ["/usr/bin/supervisord"]
#CMD ["/bin/bash"]
#WORKDIR /home/wildfly-8.1.0.Final/domain/scripts
#CMD ["./start.sh"]
