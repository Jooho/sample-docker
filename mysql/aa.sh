export NEW_FILE_NAME="jboss-eap-6.2.0.zip"
 OLD_FILE_NAME="jboss-eap-6.2.0.zip"
echo $([ $NEW_FILE_NAME =~ "jboss-eap*" ]) 
if [[ "$NEW_FILE_NAME" =~ "jboss-eap" ]]; then
     NEW_FOLDER_NAME=`echo ${NEW_FILE_NAME:0:13}`
  echo $NEW_FOLDER_NAME
  fi

