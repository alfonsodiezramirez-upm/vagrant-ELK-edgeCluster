Vagrant.configure("2") do |config|
	#Configuramos la MV de Elastic:
	config.vm.define "elastic" do |elastic|
		elastic.vm.box = "ubuntu/xenial64"
		elastic.vm.network "private_network", ip: "192.168.22.11"
		#Mapeamos el puerto 9200 de la maquina virtual con el 9200 del host y asignamos ip en red privada, aunque no es necesario puesto que al ser una subred se tiene acceso desde la maquina host a traves de la IP
		elastic.vm.network :forwarded_port, guest: 9200, host: 9200
		elastic.vm.synced_folder "./shared/", "/sharedData"
		elastic.vm.provision "shell", privileged: false,  path: "ElasticsearchProvision.sh"
	end
	#Configuramos la MV de Kibana:
	config.vm.define "kibana" do |kibana|
		kibana.vm.box = "ubuntu/xenial64"
		kibana.vm.network "private_network", ip: "192.168.22.12"
		kibana.vm.network :forwarded_port, guest: 5601, host: 5601
		kibana.vm.synced_folder "./shared/", "/sharedData"
		kibana.vm.provision "shell",  path: "KibanaProvision.sh"
	end
	#Configuramos la MV de Logstash:
	config.vm.define "logstash" do |logstash|
		logstash.vm.box = "ubuntu/xenial64"
		logstash.vm.network "private_network", ip: "192.168.22.13"
		logstash.vm.network :forwarded_port, guest: 5044, host: 5044
		logstash.vm.synced_folder "./shared/", "/sharedData"
		logstash.vm.provision "shell", privileged: false, path: "logstashProvision.sh"
	end
	#Configuramos la MV de Mosquitto y como agente ligero Filebeat:
	config.vm.define "mosquitto" do |mosquitto|
		mosquitto.vm.box = "ubuntu/xenial64"
		mosquitto.vm.network "private_network", ip: "192.168.22.20"
		mosquitto.vm.network :forwarded_port, guest: 1883, host: 1883
		mosquitto.vm.synced_folder "./shared/", "/sharedData"
		mosquitto.vm.provision "shell", path: "mosquittoProvision.sh"
		mosquitto.vm.provision "shell", path: "beatstologstashProvision.sh"
	end

end