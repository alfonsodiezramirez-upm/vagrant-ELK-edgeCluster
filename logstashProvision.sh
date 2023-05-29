wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
sudo apt-get install apt-transport-https
echo "deb https://artifacts.elastic.co/packages/8.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-8.x.list
sudo apt-get update && sudo apt-get install logstash=1:8.5.3-1 -y
pass=$(cat /sharedData/admin)
sudo cp /sharedData/pipelines.yml /etc/logstash/pipelines.yml
sudo cp /sharedData/beatstoelastic.config /etc/logstash/beatstoelastic.config
sudo sed -i "s/#PASSWORD#/$pass/g" /etc/logstash/beatstoelastic.config
sudo chown -R logstash.logstash /usr/share/logstash
sudo chmod 777 /usr/share/logstash/data
sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable logstash.service
#instalamos el plugin de mqtt, se descarta por decisión de diseño
#sudo /usr/share/logstash/bin/logstash-plugin install logstash-input-paho-mqtt
sudo systemctl start logstash.service