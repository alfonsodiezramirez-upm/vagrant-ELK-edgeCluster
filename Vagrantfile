Vagrant.configure("2") do |config|
	#Configuramos la MV de Elastic:
	config.vm.define "elastic" do |elastic|
		elastic.vm.box = "ubuntu/xenial64"
		#Definimos una ip dentro de 
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
	#Configuramos la MV de K3S que hará de master:
	config.vm.define "kubemaster" do |kubemaster|
		kubemaster.vm.box = "ubuntu/xenial64"
		kubemaster.vm.network "private_network", ip: "192.168.22.30"
		kubemaster.vm.synced_folder "./shared/", "/sharedData"
		kubemaster.vm.provision "shell", privileged: false, path: "masterNode.sh"
	end
	#Configuramos la MV de K3S que hará de primer worker:
	config.vm.define "kubeworker1" do |kubeworker1|
		kubeworker1.vm.box = "ubuntu/xenial64"
		kubeworker1.vm.hostname = "node1"
		kubeworker1.vm.network "private_network", ip: "192.168.22.31"
		kubeworker1.vm.synced_folder "./shared/", "/sharedData"
		kubeworker1.vm.provision "shell", privileged: false, path: "workerNode.sh"
	end
	#Configuramos la MV de K3S que hará de segundo worker:
	config.vm.define "kubeworker2" do |kubeworker2|
		kubeworker2.vm.box = "ubuntu/xenial64"
		kubeworker2.vm.hostname = "node2"
		kubeworker2.vm.network "private_network", ip: "192.168.22.32"
		kubeworker2.vm.synced_folder "./shared/", "/sharedData"
		kubeworker2.vm.provision "shell", privileged: false, path: "workerNode.sh"
	end
end