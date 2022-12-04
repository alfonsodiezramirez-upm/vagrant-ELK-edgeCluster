Vagrant.configure("2") do |config|
	#Configuramos la MV de Elastic:
	config.vm.define "elastic" do |elastic|
		elastic.vm.box = "ubuntu/xenial64"
		#Mapeamos el puerto 9200 de la maquina virtual con el 9200 del host y asignamos ip en red privada
		elastic.vm.network :forwarded_port, guest: 9200, host: 9200
		elastic.vm.network "private_network", ip: "192.168.22.11"
		elastic.vm.synced_folder "./shared/", "/sharedData"
		#Instalamos con un script privilegiado los pre-requisitos de elastic (JRE)
		elastic.vm.provision "shell", path: "InstallJava.sh"
		#En el script: instalamos Elastic versión 8.5.2 desde repositorio oficial, comprobando con su hash que no haya sido manipulado y ejecutamos elastic como servicio
		elastic.vm.provision "shell", privileged: false, path: "ElasticsearchProvision.sh"
	end
	config.vm.define "kibana" do |kibana|
		kibana.vm.box = "ubuntu/xenial64"
		kibana.vm.network "private_network", ip: "192.168.22.12"
		kibana.vm.network :forwarded_port, guest: 5601, host: 5601
		kibana.vm.synced_folder "./shared/", "/sharedData"
		kibana.vm.provision "shell", privileged: false, path: "KibanaProvision.sh"
	end
end