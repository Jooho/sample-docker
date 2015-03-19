PWD=$(pwd)
cd ./EWS
./docker-start.sh

cd ../EAP
./docker-start.sh -apache -v=$PWD/application -host=eap1 
./docker-start.sh -apache -v=$PWD/application -host=eap2

cd ../
docker exec apache /bin/sh -c './start_ews.sh start' 
docker exec eap1 /bin/sh -c 'cd standalone;./start.sh' &
docker exec eap2 /bin/sh -c 'cd standalone;./start.sh' &

./generate-info.sh
