. ./docker-env.sh
./update-script.sh

docker build --force-rm -t $IMAGE .
