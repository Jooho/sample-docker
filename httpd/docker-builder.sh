. ./docker-env.sh

echo "*Archieving scripts folder"
cd ./mod_cluster ; tar -cvf ../mod_cluster.tar ./ > mod_cluster.log ; cd ..
if [ $? -eq 0 ]; then
  echo "mod_cluster.tar is archieved successfully"
else
  echo "Error during archiving mod_cluster"
fi

cd ./apache_conf ; tar -cvf ../apache_conf.tar ./ > apache_conf.log ; cd ..
if [ $? -eq 0 ]; then
  echo "apache_conf.tar is archieved successfully"
else
  echo "Error during archiving apache_conf"
fi


echo "*Building docker images : " $IMAGE 

docker build -t $IMAGE .
