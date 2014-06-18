#!/bin/sh

. ./env.sh 

i#tail -f log/server.log
tail -f $DOMAIN_BASE/$SERVER_NAME/$SERVER_NAME.out

