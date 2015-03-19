. ./docker-env.sh

for iii in $1 $2
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
done


docker run \
--name="$HOST_NAME"  \
-dit --hostname="$HOST_NAME" \
$IMAGE  $CMD




