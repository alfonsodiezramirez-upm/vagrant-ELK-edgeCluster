k3stoken=$(openssl rand -base64 12)
echo $k3stoken>/sharedData/k3stoken
curl -sfL https://get.k3s.io | K3S_TOKEN=$k3stoken sh -s - server --cluster-init --node-name master --with-node-id --tls-san "192.168.22.30" --node-ip 192.168.22.30
