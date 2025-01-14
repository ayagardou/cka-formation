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

sudo hostnamectl set-hostname cp1 (or w1 for a worker node)

sudo kubeadm init --pod-network-cidr=10.244.0.0/16 
**Take note of the join command for worker nodes!
kubeadm join 10.0.0.11:6443 --token 9yhzxx.4yhs7r2k6lfgnqkm \
        --discovery-token-ca-cert-hash sha256:a951ba7275fba248021a729235aacc7c08ba9c6124642eaf911517e9704240fc

Create a cluster directory:
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml (do NOT USE SUDO HERE)
run 'ip a' show the cni0 network adapter and the IP
run 'ip route' show the route to 10.244 net via the cni0 interface

**When you use kubectl, it uses the information in the kubeconfig file to connect to the kubernetes cluster API. The default location of the Kubeconfig file is $HOME/.kube/config
kubectl cluster-info (should say that the control plane and CoreDNS are running)

kubectl get pods --all-namespaces

sudo service kubelet status

IF GETTIG CONNECTION REFUSED MSGS TRY:
open vi /etc/docker/daemon.json
change this ["native.cgroupdriver=systemd"] to "exec-opts": ["native.cgroupdriver=cgroupfs"],
sudo systemctl daemon-reload
sudo systemctl restart kubelet

OR

Put this in /etc/docker/daemon.json

{
      "exec-opts": ["native.cgroupdriver=systemd"],
      "log-driver": "json-file",
      "log-opts": {
      "max-size": "100m"
   },
       "storage-driver": "overlay2"
       }

========================
sudo ufw disable
sudo ufw status

These required ports need to be open in order for Kubernetes components to communicate with each other. You can use tools like netcat to check if a port is open. For example:
sudo nc 127.0.0.1 6443 -v
