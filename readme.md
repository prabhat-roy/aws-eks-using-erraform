Create kubernets cluster using eksctl

eksctl create cluster --name EKS-Cluster --region ap-south-2 --nodegroup-name eks-worker-nodes --node-type t3.medium --managed --nodes 2 

Update kubeconfig to connect kubernetes cluster

aws eks update-kubeconfig --region ap-south-2 --name EKS-Cluster

Run terraform apply -auto-approve to create EKS cluster


