#wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.5.2-linux-x86_64.tar.gz
#wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.5.2-linux-x86_64.tar.gz.sha512
#shasum -a 512 -c elasticsearch-8.5.2-linux-x86_64.tar.gz.sha512 
#tar -xzf elasticsearch-8.5.2-linux-x86_64.tar.gz
#mv elasticsearch-8.5.2 elasticsearch
#cd elasticsearch/
#yes |./bin/elasticsearch -d -p pid
sudo apt-get update
sudo apt-get install -y openjdk-8-jre
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg
sudo apt-get install apt-transport-https
echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/8.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-8.x.list
sudo apt-get update && sudo apt-get install elasticsearch=8.5.3 -y
sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable elasticsearch.service
sudo systemctl start elasticsearch.service
fullPass=$(yes | sudo /usr/share/elasticsearch/bin/elasticsearch-reset-password -u elastic)
pass=${fullPass: -20}
#Utilizamos para albergar la contraseña y el token un fichero en una synced folder para poder usarlo en otra Maquina virtual.
echo $pass>/sharedData/admin
#Es importante no ejecutar este comando con root dado que si ejecutamos la creación del token como tal, el fichero service_tokens no cuenta con permisos de lectura para el usuario elasticsearch y por tanto no levanta el servicio, como alternativa si se muestra el error /etc/default/elasticsearch: permission denied, podemos ejecutarlo como root y cambiar los permisos de service_tokens más adelante.
fullToken=$(sudo /usr/share/elasticsearch/bin/elasticsearch-service-tokens create elastic/kibana kibana)
token=${fullToken: -64}
echo $token>/sharedData/token
sudo chmod -R 660 /etc/elasticsearch/service_tokens