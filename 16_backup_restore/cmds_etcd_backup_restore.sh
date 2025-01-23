### BACKUP
ETCDCTL_API=3 etcdctl --endpoints=https://127.0.0.1:2379 \
--cacert=/etc/kubernetes/pki/etcd/ca.crt \
--cert=/etc/kubernetes/pki/etcd/server.crt \
--key=/etc/kubernetes/pki/etcd/server.key \
snapshot save /backups/etc_snapshot1.db


### RESTORE
ETCDCTL_API=3 etcdctl snapshot restore --data-dir="/var/lib/etcd-restored" /backups/etc_snapshot1.db
# then modify --data-dir in #/etc/kubernetes/manifests/etcd.yaml to point to the new #directorys


### PERFORMING A BACKUP AND RESTORE
# Connect with the minikube cluster
minikube ssh

# Enter root mode
sudo -i

# Verify etcdctl is installed
which etcdctl

# Set some needed environment variables
export ETCDCTL_API=3
export ETCDCTL_CACERT=/var/lib/minikube/certs/etcd/ca.crt
export ETCDCTL_CERT=/var/lib/minikube/certs/etcd/server.crt
export ETCDCTL_KEY=/var/lib/minikube/certs/etcd/server.key

# Perform the backup (snapshot)
etcdctl --endpoints=https://127.0.0.1:2379 snapshot save /tmp/etcd-snapshot.db

# Verify the backup (snapshot)
etcdctl --write-out=table snapshot status /tmp/etcd-snapshot.db

# Exit
exit
exit