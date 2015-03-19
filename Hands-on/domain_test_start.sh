cd ./EWS
./docker-start.sh

cd ../EAP
./docker-start.sh -apache -master 
./docker-start.sh -apache -slave -host=eap-slave1 -v=/ext01/docker/Hands-on/EAP/applications
./docker-start.sh -apache -slave -host=eap-slave2 -v=/ext01/docker/Hands-on/EAP/applications    

cd ../
docker exec apache /bin/sh -c './start_ews.sh start' &
docker exec eap-master /bin/sh -c 'cd master;./start.sh' &
docker exec eap-slave1 /bin/sh -c 'cd slave;./start.sh' &
docker exec eap-slave2 /bin/sh -c 'cd slave;./start.sh' &

./generate-info.sh
