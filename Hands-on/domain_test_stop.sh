echo "Stop eap containers"
cd ./EAP
./docker-stop.sh -host=eap

echo "Stop apache containers"
cd ../EWS
./docker-stop.sh 
