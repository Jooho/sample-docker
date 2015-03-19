FROM ljhiyh/centos65-handon

# Maintainer
# # ----------
MAINTAINER Jooho Lee <ljhiyh@gmail.com>
# Environment variables required for this build (do NOT change)

# Set JAVA_HOME env variable
ENV JAVA_HOME /usr/lib/jvm/java-1.7.0-openjdk-1.7.0.65.x86_64
# Set CONFIG_JVM_ARGS env variable(it is for linux bug)
ENV CONFIG_JVM_ARGS -Djava.security.egd=file:/dev/./urandom
# Set ROOT_PW env variable
ENV ROOT_PW redhat
# Set the EAP_VERSION env variable
ENV EAP_VERSION 6.4
# Set the EAP_PKG env variable
ENV EAP_PKG  jboss-eap-$EAP_VERSION
# Set the EAP_PATCH env variable
ENV EAP_PATCH 1
# Set the HOME_PATH env variable
ENV HOME_PATH /home/eap
# Set the JBOSS_HOME env variable
ENV JBOSS_HOME  $HOME_PATH/$EAP_PKG

# Upload default environment which can be known after container start up
ADD init.sh   $HOME_PATH/$EAP_PKG/
RUN . $HOME_PATH/$EAP_PKG/init.sh

#Create root user and default directories
RUN echo root:$ROOT_PW | chpasswd
RUN mkdir -p $HOME/application  && chmod a+xr $HOME 


# Upload and unzip EAP server
#ADD $EAP_PKG.0.zip $HOME_PATH/
#RUN unzip -q $HOME_PATH/$EAP_PKG.0.zip -d $HOME_PATH
#RUN rm $HOME_PATH/$EAP_PKG.0.zip

#Beta
ADD $EAP_PKG.0.Beta.zip $HOME_PATH/
RUN unzip -q $HOME_PATH/$EAP_PKG.0.Beta.zip -d $HOME_PATH
RUN rm $HOME_PATH/$EAP_PKG.0.Beta.zip

# Install PATCH
#WORKDIR $HOME_PATH/$EAP_PKG/bin
#COPY $EAP_PKG.$EAP_PATCH.zip $HOME_PATH/$EAP_PKG/bin/
#RUN $HOME_PATH/$EAP_PKG/bin/jboss-cli.sh --command="patch apply $EAP_PKG.$EAP_PATCH.zip --override-all"
#RUN rm $HOME_PATH/$EAP_PKG/bin/$EAP_PKG.$EAP_PATCH.zip

USER root

WORKDIR $HOME_PATH/$EAP_PKG
RUN bin/add-user.sh -s jboss !qaz2wsx

WORKDIR $HOME_PATH/$EAP_PKG/domain/configuration
ADD env-vm.sh $HOME_PATH/$EAP_PKG/domain/configuration/
RUN $HOME_PATH/$EAP_PKG/domain/configuration/env-vm.sh

RUN ln -s $HOME_PATH/application $HOME_PATH/$EAP_PKG/standalone/deployments
ADD scripts.tar $HOME_PATH/$EAP_PKG/

WORKDIR $HOME_PATH/$EAP_PKG/scripts
EXPOSE 22 8080 9990 9999
CMD ["/bin/bash"]
