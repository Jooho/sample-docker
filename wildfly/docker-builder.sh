. ./docker-env.sh

if [ -f ./scripts.tar ] ; then
  echo "previous script.tar will be uploaded"
else
  echo "script.tar is not found"
  echo "*Archieving scripts folder"
  tar -cvf scripts.tar ./scripts > scripts.log
  if [ $? -eq 0 ]; then
    echo "scripts.tar is archieved successfully"
  else
    echo "Error during archiving"
  fi  

fi



docker build -t $IMAGE .
