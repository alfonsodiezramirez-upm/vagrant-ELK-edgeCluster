Vagrant.configure("2") do |config|
	#Configuramos la MV de Elastic:
	config.vm.define "elastic" do |elastic|
		elastic.vm.box = "ubuntu/xenial64"
		#Mapeamos el puerto 9200 de la maquina virtual con el 9200 del host y asignamos ip en red privada
		elastic.vm.network :forwarded_port, guest: 9200, host: 9200
		elastic.vm.network "private_network", ip: "192.168.22.11"
		elastic.vm.synced_folder "./shared/", "/sharedData"
		#Instalamos con un script privilegiado los pre-requisitos de elastic (JRE)
		#elastic.vm.provision "shell", path: "InstallJava.sh"
		#En el script: instalamos Elastic versión 8.5.2 desde repositorio oficial, comprobando con su hash que no haya sido manipulado y ejecutamos elastic como servicio
		elastic.vm.provision "shell", privileged: false,  path: "ElasticsearchProvision.sh"
	end
	config.vm.define "kibana" do |kibana|
		kibana.vm.box = "ubuntu/xenial64"
		kibana.vm.network "private_network", ip: "192.168.22.12"
		kibana.vm.network :forwarded_port, guest: 5601, host: 5601
		kibana.vm.synced_folder "./shared/", "/sharedData"
		kibana.vm.provision "shell",  path: "KibanaProvision.sh"
	end
	config.vm.define "mosquitto" do |mosquitto|
		mosquitto.vm.box = "ubuntu/xenial64"
		mosquitto.vm.network "private_network", ip: "192.168.22.20"
		mosquitto.vm.network :forwarded_port, guest: 1883, host: 1883
		mosquitto.vm.provision "shell", path: "mosquittoProvision.sh"
	end
	config.vm.define "logstash" do |logstash|
		logstash.vm.box = "ubuntu/xenial64"
		logstash.vm.network "private_network", ip: "192.168.22.13"
		logstash.vm.synced_folder "./shared/", "/sharedData"
		logstash.vm.provision "shell", privileged: false, path: "logstashProvision.sh"
	end
end