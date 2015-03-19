. ./docker-env.sh 

for iii in $1 $2 $3 $4 $5 $6

do
	if ( echo $iii | grep "\-host" &> /dev/null ) 
	then
		c_host=`echo $iii | awk -F "=" '{print $2}'`
		if [[ z$c_host == z ]]; then
			echo usage : -host=jboss1
			exit 1
		else
			HOST_NAME=$c_host
		fi
	fi
        if ( echo $iii | grep "\-cmd" &> /dev/null )
           then
                   c_cmd=`echo $iii | awk -F "=" '{print $2}'`
                   if [[ z$c_cmd == z ]]; then
                          echo usage : -cmd=/bin/bash
                          exit 1
                  else
                          CMD=$c_cmd
                  fi
          fi
          if ( echo $iii | grep "\-slave" &> /dev/null )
           then
                  SLAVE="--link eap-master:eap-master"
          fi
          if ( echo $iii | grep "\-master" &> /dev/null )
           then
                  HOST_NAME=eap-master
          fi
          if ( echo $iii | grep "\-apache" &> /dev/null )
           then
                   c_apache=`echo $iii | awk -F "=" '{print $2}'`
                   if [[ z$c_apache != z ]]; then
                          echo usage : -apache
                          exit 1
                  else
                          APACHE="--link apache:apache"
                  fi
          fi
          if ( echo $iii | grep "\-v" &> /dev/null )
           then
                   c_volume=`echo $iii | awk -F "=" '{print $2}'`
                   if [[ z$c_volume == z ]]; then
                          echo usage : -v=./application
                          echo ./application will be mount to application folder inside docker container
                          echo /home/eap/application
                          exit 1
                  else
                          VOLUME="-v $c_volume:/home/eap/application"
                  fi
          fi


done

docker run \
--name="$HOST_NAME" $SLAVE $APACHE $VOLUME \
-dit --hostname="$HOST_NAME" \
$IMAGE  $CMD

#-p 18080:8080 \
