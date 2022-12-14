wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg
sudo apt-get update
sudo apt-get install apt-transport-https
echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/8.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-8.x.list
sudo apt-get update && sudo apt-get install kibana=8.5.3 -y
token=$(cat /sharedData/token)
sudo echo "server.host: \"192.168.22.12\"">/etc/kibana/kibana.yml
sudo echo "server.port: 5601">>/etc/kibana/kibana.yml
sudo echo "elasticsearch.hosts: \"https://192.168.22.11:9200\"">>/etc/kibana/kibana.yml
sudo echo "elasticsearch.serviceAccountToken: \"$token\"">>/etc/kibana/kibana.yml
sudo echo "elasticsearch.ssl.verificationMode: \"none\"">>/etc/kibana/kibana.yml
sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable kibana.service
sudo systemctl start kibana.service