FROM docker-registry:5000/centos65:basic
ADD epel-release-6-8.noarch.rpm /etc/yum.repos.d/
RUN rpm -ivh /etc/yum.repos.d/epel-release-6-8.noarch.rpm
RUN yum update -y
RUN yum install -y java-1.7.0-openjdk
RUN yum install -y unzip
RUN yum install -y openssh-server 
RUN yum install -y openssh-clients
RUN yum install -y supervisor
RUN yum install -y bind
ADD supervisord.conf /home/supervisord.conf
RUN cat /home/supervisord.conf > /etc/supervisord.conf
ADD bashrc  /home/bashrc
RUN cat /home/bashrc >> /etc/profile
RUN echo 'root:redhat' | chpasswd
ADD bind/named.conf /etc/
ADD bind/named.jhouse.zones /etc/
ADD bind/172.17.42.net /var/named/
ADD bind/10.64.160.net /var/named/
ADD bind/named.jhouse /var/named/
EXPOSE 22 8080 9990 9999
CMD ["/usr/bin/supervisord"]
#CMD ["/bin/bash"]
#WORKDIR /home/jboss-eap-6.2/domain/scripts
#CMD ["./start.sh"]
