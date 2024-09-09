Create kubernets cluster using eksctl

eksctl create cluster --name EKS-Cluster-1 --region ap-south-2 --nodegroup-name eks-worker-nodes --node-type t3.medium --managed --nodes 2 

Connect kubernetes cluster
Update kubeconfig
#aws eks update-kubeconfig --region region-code --name my-cluster
aws eks update-kubeconfig --region ap-south-2 --name EKS-Cluster-1


