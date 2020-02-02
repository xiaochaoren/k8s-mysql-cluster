# deploy master-slave cluster

# store account in secret
kubectl apply -f ./mysql-accounts/secret.yml

#deploy storage
kubectl apply -f ./mysql-master-slave/storage.yml

# deploy basic service
kubectl apply -f ./mysql-master-slave/deploy-base.yml

# deploy master nodes
kubectl apply -f ./mysql-master-slave/deploy-master.yml

# deploy slave nodes
kubectl apply -f ./mysql-master-slave/deploy-slave.yml

