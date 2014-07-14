#!/bin/bash
NEW_FILE_NAME="jboss-eap-6.2.0.zip"
OLD_FILE_NAME="wildfly-8.1.0.CR2.zip"
#OLD_FILE_NAME="jboss-eap-6.3.0.Beta.zip"
export NEW_FOLDER_NAME=""
export OLD_FOLDER_NAME=""
me=`basename $0`

for iii in $1 $2 $3

do
        if ( echo $iii | grep "\-old" &> /dev/null ) 
        then
                c_old=`echo $iii | awk -F "=" '{print $2}'`
                if [[ z$c_old == z ]]; then
                        echo usage : -old=jboss-eap-6.2.0.zip
                        exit 1
                else
                        OLD_FILE_NAME=$c_old
                fi
        fi
        if ( echo $iii | grep "\-new" &> /dev/null )
        then    
                c_new=`echo $iii | awk -F "=" '{print $2}'`
                if [[ z$c_new == z ]]; then
                        echo usage : -new=jboss-eap-6.3.0.Beta.zip
                        exit 1
                else

                         NEW_FILE_NAME=$c_new
                fi
        fi
        if ( echo $iii | grep "\-debug" &> /dev/null ) 
        then
                c_debug=true
        fi
done


if [[ $NEW_FILE_NAME =~ "jboss-eap" ]]; then
   NEW_FOLDER_NAME=`echo ${NEW_FILE_NAME:0:13}`
elif [[ $NEW_FILE_NAME =~ "wildfly" ]]; then
    NEW_FOLDER_NAME=${NEW_FILE_NAME%.*}
fi

if [[ $OLD_FILE_NAME =~ "jboss-eap" ]]; then
   OLD_FOLDER_NAME=`echo ${OLD_FILE_NAME:0:13}`
elif [[ $OLD_FILE_NAME =~ "wildfly" ]]; then
   OLD_FOLDER_NAME=${OLD_FILE_NAME%.*}
fi



echo -n "*Changing files"
for file in $(find . -type f)
do
  if [ -f $file -a -r $file ] && [ "$file" != './'"$me" ] && [ "${file##*.}" != 'zip' ]; then
        perl -pi -e "s/$OLD_FILE_NAME/$NEW_FILE_NAME/g" "$file"
        perl -pi -e "s/$OLD_FOLDER_NAME/$NEW_FOLDER_NAME/g" "$file"
        echo -n "."
 elif [ "$file" == './'"$me" ]; then
        echo -n "m"
 elif [ "${file##*.}" == 'zip' ]; then
 	echo -n i 
 else
 	 echo "Error: Cannot read $file"
  fi  
done



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

  


