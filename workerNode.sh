k3stoken=$(cat /sharedData/k3stoken)
curl -sfL https://get.k3s.io | K3S_URL=https://192.168.22.30:6443 K3S_TOKEN="$k3stoken" sh -