k3stoken=$(openssl rand -base64 12)
echo $k3stoken>/sharedData/k3stoken
curl -sfL https://get.k3s.io | K3S_TOKEN=$k3stoken K3S_KUBECONFIG_MODE="644" sh -s - server --cluster-init --node-name master --with-node-id --tls-san "192.168.22.30" --node-ip 192.168.22.30
#Despliegue de imagenes de prueba del entorno, con 3 replicas:
kubectl create deployment --image=alfonsoiot/devices-tfm devices
kubectl scale --replicas=3 deployment/devices

GITHUB_URL=https://github.com/kubernetes/dashboard/releases
VERSION_KUBE_DASHBOARD=$(curl -w '%{url_effective}' -I -L -s -S ${GITHUB_URL}/v2.7.0 -o /dev/null | sed -e 's|.*/||')
sudo k3s kubectl create -f https://raw.githubusercontent.com/kubernetes/dashboard/${VERSION_KUBE_DASHBOARD}/aio/deploy/recommended.yaml
sudo k3s kubectl create -f /sharedData/K3SDashboard/dashboard.admin-user.yml -f /sharedData/K3SDashboard/dashboard.admin-user-role.yml

sudo k3s kubectl -n kubernetes-dashboard create token admin-user > /sharedData/K3SDashboard/admin-user_token

kubectl patch svc kubernetes-dashboard -n kubernetes-dashboard --type='json' -p '[{"op":"replace","path":"/spec/type","value":"LoadBalancer"}]'

PORT=$(kubectl get svc -n kubernetes-dashboard -o go-template='{{range .items}}{{range.spec.ports}}{{if .nodePort}}{{.nodePort}}{{"\n"}}{{end}}{{end}}{{end}}')
URL="https://192.168.22.30:${PORT}/#/login"
echo "${URL}">/sharedData/K3SDashboard/dashboardURL