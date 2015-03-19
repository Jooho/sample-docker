. ./docker-env.sh
./update-conf.sh

echo "*Building docker images : " $IMAGE 

docker build -t $IMAGE .

