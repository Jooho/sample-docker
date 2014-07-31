. ./docker-env.sh

echo -n "end"
echo ""
echo "##############################################"
echo "# Original Install File : $OLD_FILE_NAME #"
echo "# New Install File : $NEW_FILE_NAME #"
echo "##############################################"

echo "*Archieving scripts folder"
tar -cvf scripts.tar ./scripts > scripts.log
if [ $? -eq 0 ]; then
  echo "scripts.tar is archieved successfully"
else
  echo "Error during archiving"
fi


docker build -t $IMAGE .
