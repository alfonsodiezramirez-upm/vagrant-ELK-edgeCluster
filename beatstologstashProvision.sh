wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
sudo apt-get install apt-transport-https
echo "deb https://artifacts.elastic.co/packages/8.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-8.x.list
sudo apt-get update && sudo apt-get install filebeat=8.5.3
sudo cp /sharedData/filebeat.yml /etc/filebeat/filebeat.yml
pass=$(cat /sharedData/admin)
sudo sed -i "s/#PASSWORD#/$pass/g" /etc/filebeat/filebeat.yml
sudo systemctl daemon-reload
sudo systemctl enable filebeat
sudo systemctl start filebeat