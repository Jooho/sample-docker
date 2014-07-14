. ./docker-env.sh

echo "*Archieving scripts folder"
tar -cvf mod_cluster.tar ./mod_cluster > mod_cluster.log
if [ $? -eq 0 ]; then
  echo "mod_cluster.tar is archieved successfully"
else
  echo "Error during archiving mod_cluster"
fi

tar -cvf apache_conf.tar ./apache_conf > apache_conf.log
if [ $? -eq 0 ]; then
  echo "apache_conf.tar is archieved successfully"
else
  echo "Error during archiving apache_conf"
fi


echo "*Building docker images : " $IMAGE 

docker build -t $IMAGE .
