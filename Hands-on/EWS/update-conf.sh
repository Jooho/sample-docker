. ./docker-env.sh

echo "*Archieving scripts folder"

CONNECTOR_PKG=jboss-eap-native-webserver-connectors-$EAP_VERSION.0-RHEL6-x86_64.zip
MODULE_PATH=jboss-eap-$EAP_VERSION/modules/system/layers/base/native/lib64/httpd/modules

#Extract mod_cluster module to mod_cluster folder
mkdir temp
rm ./mod_cluster/* 
cp $CONNECTOR_PKG ./temp 
echo unzip ./temp/$CONNECTOR_PKG
cd ./temp
unzip $CONNECTOR_PKG
echo cp /$MODULE_PATH/* ./mod_cluster
cp $MODULE_PATH/* ../mod_cluster
cd ..
rm -rf ./temp

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


