resource "aws_eks_cluster" "default" {
  name     = var.name
  role_arn = aws_iam_role.default.arn

  vpc_config {
    subnet_ids = var.private_subnet_ids
  }

  enabled_cluster_log_types = ["api", "audit"]

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_cloudwatch_log_group.control_plane,
    aws_iam_role_policy_attachment.default_AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.default_AmazonEKSServicePolicy,
  ]
}