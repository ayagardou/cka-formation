sudo apt update
sudo apt install -y docker.io
docker --version
sudo service docker status

sudo swapoff -a

sudo apt-get install -y apt-transport-https ca-certificates curl gpg

curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

sudo systemctl enable --now kubelet

kubeadm join 10.0.0.11:6443 --token s5ewoz.ziumn5kvi77m3btj --discovery-token-ca-cert-hash sha256:a951ba7275fba248021a729235aacc7c08ba9c6124642eaf911517e9704240fc

kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml (do NOT USE SUDO HERE)