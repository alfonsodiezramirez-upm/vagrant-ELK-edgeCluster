k3stoken=$(openssl rand -base64 12)
echo $k3stoken>/sharedData/k3stoken
curl -sfL https://get.k3s.io | K3S_TOKEN=$k3stoken K3S_KUBECONFIG_MODE="644" sh -s - server --cluster-init --node-name master --with-node-id --tls-san "192.168.22.30" --node-ip 192.168.22.30
#Despliegue de imagenes de prueba del entorno, con 3 replicas:
kubectl create deployment --image=alfonsoiot/devices-tfm devices
kubectl scale --replicas=3 deployment/devices
