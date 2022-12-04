wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.5.2-linux-x86_64.tar.gz
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.5.2-linux-x86_64.tar.gz.sha512
shasum -a 512 -c elasticsearch-8.5.2-linux-x86_64.tar.gz.sha512 
tar -xzf elasticsearch-8.5.2-linux-x86_64.tar.gz
mv elasticsearch-8.5.2 elasticsearch
cd elasticsearch/
yes |./bin/elasticsearch -d -p pid
fullPass=$(yes | bin/elasticsearch-reset-password -u elastic)
pass=${fullPass: -20}
#Utilizamos para albergar la contraseña y el token un fichero en una synced folder para poder usarlo en otra Maquina virtual.
echo $pass>/sharedData/admin
fullToken=$(bin/elasticsearch-service-tokens create elastic/kibana kibana)
token=${fullToken: -64}
echo $token>/sharedData/token
cp /home/vagrant/elasticsearch/config/elasticsearch.yml /sharedData/elasticsearch.yml