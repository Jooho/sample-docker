. ./docker-env.sh 

docker run \
--name="$HOST_NAME" \
-i -t -h="$HOST_NAME" \
--dns="$DNS" \
-n=false \
-lxc-conf="lxc.network.type=veth" \
-lxc-conf="lxc.network.ipv4=${IP}/24" \
-lxc-conf="lxc.network.ipv4.gateway=172.17.42.1" \
-lxc-conf="lxc.network.link=docker0" \
-lxc-conf="lxc.network.name=eth0" \
-lxc-conf="lxc.network.flags=up" \
$IMAGE   
