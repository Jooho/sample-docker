FROM docker-registry:5000/rhel65-base
ADD rhel.repo  /etc/yum.repo.d/
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
ADD jboss-eap-6.2.0.zip /home/
RUN unzip -q /home/jboss-eap-6.2.0.zip -d /home
ADD scripts.tar /home/jboss-eap-6.2
ADD env_vm.sh /home/jboss-eap-6.2/domain/configuration/
WORKDIR /home/jboss-eap-6.2/domain/configuration
RUN /home/jboss-eap-6.2/domain/configuration/env_vm.sh
WORKDIR /home/jboss-eap-6.2
RUN mkdir -p domain/scripts
RUN bin/add-user.sh -s jboss !qaz2wsx
EXPOSE 22 8080 9990 9999
CMD ["/usr/bin/supervisord"]
#CMD ["/bin/bash"]
#WORKDIR /home/jboss-eap-6.2/domain/scripts
#CMD ["./start.sh"]
