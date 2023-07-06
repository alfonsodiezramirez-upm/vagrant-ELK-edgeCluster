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

sleep 120

#Cargamos el dashboard y sus dependencias mediante curl, para disponer de ello desde el arranque, si lo cambiamos, deberemos exportar el dashboard utilizando el curl curl GET 192.168.22.12:5601/api/kibana/dashboards/export?dashboard=15393120-1ab0-11ee-85ef-d37137d9859b
admin=$(cat /sharedData/admin)
curl --location --request POST '192.168.22.12:5601/api/kibana/dashboards/import?force=True' --header 'kbn-xsrf: reporting'  --user "elastic:$admin" --header 'Content-Type: application/json' -d @/sharedData/kibana/dashboardanddependencies.json