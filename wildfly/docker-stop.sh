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
done



echo "############### Running Docker Container ###############"
docker ps 

echo ""
echo ""

echo "############### Stopped Docker Container ###############"
docker ps -a

export CONTAINER_NUM=`docker ps -a | grep  $HOST_NAME  |awk '{print $1}'`
export RUNNING_CONTAINER_NUM=`docker ps  |grep  $HOST_NAME |awk '{print $1}'`

for r in $RUNNING_CONTAINER_NUM;do
   echo docker stop $r
   docker stop $r
done

for c in $CONTAINER_NUM;do
   echo docker rm $c
   docker rm $c
done
