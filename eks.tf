resource "aws_eks_cluster" "cluster1" {
  name     = "EKS-Cluster-1"
  role_arn = aws_iam_role.eks-iam-role.arn
  vpc_config {
    subnet_ids = concat(local.public_subnet_ids, local.private_subnet_ids)
  }
  depends_on = [aws_iam_role.eks-iam-role]
}

resource "aws_eks_node_group" "worker-node-group" {
  cluster_name    = aws_eks_cluster.cluster1.name
  node_group_name = "worker_node_group_1"
  node_role_arn   = aws_iam_role.workernodes.arn
  subnet_ids      = aws_subnet.private_subnet[*].id
  instance_types  = [var.instance_type]
  capacity_type = "ON_DEMAND"
  disk_size = "20"
  remote_access {
    ec2_ssh_key = var.ssh_key
  }

  scaling_config {
    desired_size = 2
    max_size     = 5
    min_size     = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
}

locals {
  public_subnet_ids  = aws_subnet.public_subnet.*.id
  private_subnet_ids = aws_subnet.private_subnet.*.id
}