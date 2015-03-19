SetIP(){
    EAP_1_IP=$(docker inspect --format '{{.NetworkSettings.IPAddress}}' $EAP_1_NAME)
    EAP_2_IP=$(docker inspect --format '{{.NetworkSettings.IPAddress}}' $EAP_2_NAME)
}
#Check domain or standalone
  if [ z$1 == 'domain' ]; then
    EAP_1_NAME=eap-slave1
    EAP_2_NAME=eap-slave2
    SetIP
    EAP_MASTER_IP=$(docker inspect --format '{{.NetworkSettings.IPAddress}}' eap-master)
    EAP_DOMAIN_CONTROLLER="http://$EAP_MASTER_IP:9990"
else
    EAP_1_NAME="eap1"
    EAP_2_NAME="eap2"
    SetIP
    EAP_1_ADMIN_CONSOLE="http://$EAP_1_IP:9990"
    EAP_2_ADMIN_CONSOLE="http://$EAP_2_IP:9990"
 fi

APACHE_IP=$(docker inspect --format '{{.NetworkSettings.IPAddress}}' apache)

APACHE_MOD_CLUSTER_URL="http://$APACHE_IP:6666/mod_cluster_manager"
APACHE_SERVER_STATUS_URL="http://$APACHE_IP:6666/server_status"
APACHE_TEST_URL="http://$APACHE_IP/eap6"
EAP_1_TEST_URL="http://$EAP_1_IP:8080/eap6"
EAP_2_TEST_URL="http://$EAP_2_IP:8080/eap6"

rm ./info.html
cat << puha > info.html
 <!DOCTYPE html>                                                  
 <html>
 <body>
<style>
td {
border-style:solid; border-width:1px;
}
 
</style>
 <table style="width:50%;text-align:center;border-style:solid; border-width:1px;">
   <tr>
     <td>APACHE</td>
   </tr>
   <tr>
     <td>IP</td>
     <td>$APACHE_IP</td>
   </tr>
   <tr>
     <td>Mod Cluster Manager</td>
     <td><a href="$APACHE_MOD_CLUSTER_URL" target="_blank" >Open</a></td>
   </tr>
   <tr>
     <td>Server Status</td>
     <td><a href="$APACHE_SERVER_STATUS_URL" target="_blank">Open</a></td>
   </tr>
   <tr>
     <td>Test Page</td>
     <td><a href="$APACHE_TEST_URL" target="_blank" >Open</a></td>
   </tr>
   <tr>
     <td>EAP</td>
   </tr>
   <tr>
     <td>$EAP_1_NAME IP</td>
     <td>$EAP_1_IP</td>
   </tr>
   <tr>
     <td>$EAP_2_NAME IP</td>
     <td>$EAP_2_IP</td>
   </tr>

puha

if [ z$1 == 'domain' ]; then
cat << puha >> info.html
   <tr>
     <td>Master IP</td>
     <td>$EAP_MASTER_IP</td>
   </tr>
   <tr>
     <td>Domain Controller</td>
     <td><a href="$EAP_DOMAIN_CONTROLLER" target="_blank" >Open</a></td>
   </tr>
puha
else
cat << puha >> info.html
   <tr>
     <td>$EAP_1_NAME Admin Console</td>
     <td><a href="$EAP_1_ADMIN_CONSOLE" target="_blank" >Open</a></td>
   </tr>
    <tr>
     <td>$EAP_2_NAME Admin Console</td>
     <td><a href="$EAP_2_ADMIN_CONSOLE" target="_blank" >Open</a></td>
   </tr>
puha
fi

 cat << puha >> info.html
   <tr>
     <td>$EAP_1_Name Test Page</td>
     <td><a href="$EAP_1_TEST_URL" target="_blank" >Open</a></td>
   </tr>
   <tr>
     <td>$EAP_2_Name Test Page</td>
     <td><a href="$EAP_2_TEST_URL" target="_blank" >Open</a></td>
   </tr>
 </table>
 </body>
 </html>
puha
