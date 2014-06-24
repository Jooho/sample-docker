. ./docker-env.sh 

for iii in $1 $2 $3

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
	if ( echo $iii | grep "\-ip" &> /dev/null )
	then	
		c_ip=`echo $iii | awk -F "=" '{print $2}'`
		if [[ z$c_ip == z ]]; then
			echo usage : -ip=172.17.42.20
			exit 1
		else

			IP=$c_ip
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

#--dns=["$DNS","10.64.255.25"] \
docker run \
--name="$HOST_NAME" \
-i -t -h="$HOST_NAME" \
-P \
--net="none"  \
--lxc-conf="lxc.network.type=veth" \
--lxc-conf="lxc.network.ipv4=${IP}/24" \
--lxc-conf="lxc.network.ipv4.gateway=172.17.42.1" \
--lxc-conf="lxc.network.link=docker0" \
--lxc-conf="lxc.network.name=eth0" \
--lxc-conf="lxc.network.flags=up" \
$IMAGE  $CMD
