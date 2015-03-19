#!/bin/bash

echo "*Remove scripts.tar"
rm scripts.tar
echo "*Archieving scripts folder"
tar -cvf scripts.tar ./scripts > scripts.log
if [ $? -eq 0 ]; then
  echo "scripts.tar is archieved successfully"
else
  echo "Error during archiving"
fi

  


