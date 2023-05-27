k3stoken=$(openssl rand -base64 12)
echo $k3stoken>/sharedData/k3stoken
curl -sfL https://get.k3s.io | K3S_TOKEN=$k3stoken K3S_KUBECONFIG_MODE="644" sh -s - server --cluster-init --node-name master --with-node-id --tls-san "192.168.22.30" --node-ip 192.168.22.30
#sudo cp /sharedData/k3s.yaml /etc/rancher/k3s/k3s.yaml
#export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
#GITHUB_URL=https://github.com/kubernetes/dashboard/releases
#VERSION_KUBE_DASHBOARD=$(curl -w '%{url_effective}' -I -L -s -S ${GITHUB_URL}/latest -o /dev/null | sed -e 's|.*/||')
#sudo k3s kubectl create -f https://raw.githubusercontent.com/kubernetes/dashboard/${VERSION_KUBE_DASHBOARD}/aio/deploy/recommended.yaml
#sudo k3s kubectl create -f /sharedData/dashboard.admin-user.yml -f /sharedData/dashboard.admin-user-role.yml
#sudo cat k3s kubectl -n kubernetes-dashboard create token admin-user >  /sharedData/k3stoken
#sudo k3s kubectl proxy &
kubectl create deployment --image=alfonsoiot/devices-tfm devices
kubectl scale --replicas=3 deployment/devices
