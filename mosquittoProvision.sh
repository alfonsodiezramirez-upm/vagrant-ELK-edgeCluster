sudo apt update
sudo apt install openjdk-11-jre -y
sudo apt-get install mosquitto -y
sudo apt-get install mosquitto-clients -y
sudo /bin/systemctl daemon-reload
sudo systemctl enable mosquitto.service
sudo systemctl start mosquitto.service