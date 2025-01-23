echo 
echo "**** install docker ****"
echo 

apt-get update
apt-get install -y docker.io

swapoff -a
cp /etc/fstab /etc/fstab.bkp
sed -i.bak '/ swap / s/^\(.*\)$/#/g' /etc/fstab

echo '{"exec-opts": ["native.cgroupdriver=systemd"],"log-driver": "json-file","log-opts": {"max-size": "100m"},"storage-driver": "overlay2"}' > /etc/docker/daemon.json
systemctl restart docker

sudo apt-get install -y apt-transport-https ca-certificates curl gpg
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | tee /etc/apt/sources.list.d/kubernetes.list


echo 
echo "**** install kubectl, kubeadm and kubelet ****"
echo 

apt-get update
apt-get install -y kubeadm kubectl kubelet
