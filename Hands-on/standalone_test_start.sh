cd ./EWS
./docker-start.sh

cd ../EAP
./docker-start.sh -apache -v=/ext01/docker/Hands-on/EAP/applications -host=eap2
./docker-start.sh -apache -v=/ext01/docker/Hands-on/EAP/applications -host=eap1

cd ../
docker exec apache /bin/sh -c './start_ews.sh start' 
docker exec eap1 /bin/sh -c 'cd standalone;./start.sh' &
docker exec eap2 /bin/sh -c 'cd standalone;./start.sh' &

