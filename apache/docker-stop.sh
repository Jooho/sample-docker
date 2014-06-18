. ./docker-env.sh 

echo "############### Running Docker Container ###############"
docker ps 

echo ""
echo ""

echo "############### Stopped Docker Container ###############"
docker ps -a

export CONTAINER_NUM=`docker ps -a | grep $IMAGE  |awk '{print $1}'`
export RUNNING_CONTAINER_NUM=`docker ps  |grep $IMAGE |awk '{print $1}'`

for r in $RUNNING_CONTAINER_NUM;do
   echo docker stop $r
   docker stop $r
done

for c in $CONTAINER_NUM;do
   echo docker rm $c
   docker rm $c
done
