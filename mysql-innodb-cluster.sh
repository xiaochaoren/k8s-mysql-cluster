# deploy master-slave cluster

#deploy storage
kubectl apply -f ./mysql-innodb-cluster/storage.yml

# deploy basic service
kubectl apply -f ./mysql-innodb-cluster/deploy-base.yml

# deploy primary nodes
kubectl apply -f ./mysql-innodb-cluster/deploy-primary.yml

# deploy secondary nodes
kubectl apply -f ./mysql-innodb-cluster/deploy-secondary.yml

