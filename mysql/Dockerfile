FROM docker-registry:5000/rhel65-base
ADD rhel.repo  /etc/yum.repo.d/
ADD epel-release-6-8.noarch.rpm /etc/yum.repos.d/
RUN rpm -ivh /etc/yum.repos.d/epel-release-6-8.noarch.rpm
RUN yum update -y
RUN yum install -y java-1.7.0-openjdk
RUN yum install -y unzip
RUN yum install -y openssh-server 
RUN yum install -y openssh-clients
RUN yum install -y mysql-server
RUN yum install -y supervisor
ADD supervisord.conf /home/supervisord.conf
RUN cat /home/supervisord.conf > /etc/supervisord.conf
WORKDIR /home/
ADD docker-env.sh /home/
ADD bashrc  /home/bashrc
RUN cat /home/bashrc >> /etc/profile
RUN echo 'root:redhat' | chpasswd
ADD mysql_conf.sql /home/
ADD env_vm.sh /home/
ADD test_data.sql /home/
EXPOSE 22 3306
CMD ["/bin/bash", "/home/env_vm.sh"]
#CMD ["/bin/bash"]
#WORKDIR /home/jboss-eap-6.2/domain/scripts
#CMD ["./start.sh"]
