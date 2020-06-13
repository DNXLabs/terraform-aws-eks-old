data "aws_ssm_parameter" "eks_ami" {
  name = "/aws/service/eks/optimized-ami/${aws_eks_cluster.default.version}/amazon-linux-2/recommended/image_id"
}