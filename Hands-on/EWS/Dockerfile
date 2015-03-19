FROM ljhiyh/centos65-handon

# Maintainer
# # ----------
MAINTAINER Jooho Lee <ljhiyh@gmail.com>

#Yum install
RUN yum install httpd -y

# Environment variables required for this build (do NOT change)
# Set ROOT_PW env variable
ENV ROOT_PW redhat
# Set the EWS_VERSION env variable
ENV EWS_VERSION 2.1
# Set the EWS_PKG env variable
ENV EWS_PKG  jboss-ews-httpd-$EWS_VERSION.0-RHEL6-x86_64 
# Set the HOME_PATH env variable
ENV HOME_PATH /home/ews
# Set the JBOSS_HOME env variable
ENV EWS_HOME  $HOME_PATH/jboss-ews-$EWS_VERSION

#Create root user and default directories
RUN echo root:$ROOT_PW | chpasswd
RUN mkdir -p $HOME_PATH  && chmod a+xr $HOME_PATH
RUN mkdir -p $EWS_HOME/httpd/docs/ws1
RUN mkdir -p $EWS_HOME/httpd/docs/ws2
RUN mkdir -p $EWS_HOME/httpd/docs/ws3


ADD jboss-ews-httpd-$EWS_VERSION.0-RHEL6-x86_64.zip $HOME_PATH/
RUN unzip -q $HOME_PATH/jboss-ews-httpd-$EWS_VERSION.0-RHEL6-x86_64.zip -d $HOME_PATH/
RUN rm $HOME_PATH/jboss-ews-httpd-$EWS_VERSION.0-RHEL6-x86_64.zip 

#ADD bashrc $HOME_PATH/tmp/bashrc
#RUN cat $HOME_PATH/tmp/bashrc >> /etc/profile
ADD env-vm.sh $EWS_HOME/httpd/
WORKDIR $EWS_HOME/httpd
RUN . $EWS_HOME/httpd/env-vm.sh 
ADD apache_conf.tar  $EWS_HOME/httpd/conf.d/
ADD mod_cluster.tar $EWS_HOME/httpd/modules/
ADD start_ews.sh $EWS_HOME/httpd/
EXPOSE 22 80 6666
CMD ["/bin/bash"]
