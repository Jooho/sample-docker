#!/bin/sh

DATE=`date +%Y%m%d%H%M%S`

. ./env.sh

PID=`ps -ef | grep java | grep "=$SERVER_NAME " | grep "Host Controller" | awk '{print $2}'`
echo $PID

if [ e$PID != "e" ]
then
    echo "JBoss SERVER - $SERVER_NAME is already RUNNING..."
    exit;
fi

UNAME=`id -u -n`
if [ e$UNAME != "e$JBOSS_USER" ]
then
    echo "Use $JBOSS_USER account to start JBoss SERVER - $SERVER_NAME..."
    exit;
fi

echo $JAVA_OPTS

mkdir -p $DOMAIN_BASE/$SERVER_NAME/nohup

mv $DOMAIN_BASE/$SERVER_NAME/$SERVER_NAME.out $DOMAIN_BASE/$SERVER_NAME/nohup/$SERVER_NAME.out.$DATE

if [[ $LAUNCH_JBOSS_IN_BACKGROUND == "true" ]]
then
	nohup $JBOSS_HOME/bin/domain.sh -DSERVER=$SERVER_NAME  >> $DOMAIN_BASE/$SERVER_NAME/$SERVER_NAME.out &
else
	$JBOSS_HOME/bin/domain.sh -DSERVER=$SERVER_NAME 
fi

if [ e$1 = "enotail" ]
then
    echo "Starting... $SERVER_NAME"
    exit;
fi

#tail -f log/server.log
tail -f $DOMAIN_BASE/$SERVER_NAME/$SERVER_NAME.out
