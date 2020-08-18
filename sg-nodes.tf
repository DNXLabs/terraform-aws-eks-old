resource "aws_security_group" "eks_nodes" {
  name        = "eks-${var.name}-nodes"
  description = "SG for EKS nodes"
  vpc_id      = var.vpc_id

  tags = {
    Name                                                    = "eks-${var.name}-nodes",
    "kubernetes.io/cluster/${aws_eks_cluster.default.name}" = "owned"
  }
}

resource "aws_security_group_rule" "all_from_eks_nodes_to_eks_nodes" {
  description              = "Traffic between EKS nodes"
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.eks_nodes.id
  source_security_group_id = aws_security_group.eks_nodes.id
}

resource "aws_security_group_rule" "all_from_ecs_nodes_world" {
  description       = "Traffic to internet"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.eks_nodes.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "to_eks_control_plane_from_eks_nodes_api_server" {
  description              = "Traffic EKS control plane and nodes (API Server)"
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_eks_cluster.default.vpc_config[0].cluster_security_group_id
  source_security_group_id = aws_security_group.eks_nodes.id
}

resource "aws_security_group_rule" "to_eks_control_plane_from_eks_nodes_kubelet" {
  description              = "Traffic EKS control plane and nodes (kubelet)"
  type                     = "ingress"
  from_port                = 1025
  to_port                  = 65535
  protocol                 = "tcp"
  security_group_id        = aws_eks_cluster.default.vpc_config[0].cluster_security_group_id
  source_security_group_id = aws_security_group.eks_nodes.id
}

resource "aws_security_group_rule" "from_eks_control_plane_to_eks_nodes_kubelet" {
  description              = "Traffic EKS control plane and nodes (kubelet)"
  type                     = "egress"
  from_port                = 1025
  to_port                  = 65535
  protocol                 = "tcp"
  security_group_id        = aws_eks_cluster.default.vpc_config[0].cluster_security_group_id
  source_security_group_id = aws_security_group.eks_nodes.id
}

resource "aws_security_group_rule" "from_eks_control_plane_to_eks_nodes_api_server" {
  description              = "Traffic EKS control plane and nodes (API Server)"
  type                     = "egress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_eks_cluster.default.vpc_config[0].cluster_security_group_id
  source_security_group_id = aws_security_group.eks_nodes.id
}

resource "aws_security_group_rule" "to_eks_nodes_from_eks_control_plane_kubelet" {
  description              = "Traffic EKS control plane and nodes (API Server)"
  type                     = "ingress"
  from_port                = 1025
  to_port                  = 65535
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks_nodes.id
  source_security_group_id = aws_eks_cluster.default.vpc_config[0].cluster_security_group_id
}

resource "aws_security_group_rule" "to_eks_nodes_from_eks_control_plane_api_server" {
  description              = "Traffic EKS control plane and nodes (API Server)"
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks_nodes.id
  source_security_group_id = aws_eks_cluster.default.vpc_config[0].cluster_security_group_id
}