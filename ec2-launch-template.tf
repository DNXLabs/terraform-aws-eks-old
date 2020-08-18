data "template_file" "userdata" {
  template = file("${path.module}/userdata.tpl")

  vars = {
    tf_cluster_name = aws_eks_cluster.default.name
    # tf_efs_id       = aws_efs_file_system.ecs.id
    userdata_extra = var.userdata
  }
}

resource "aws_launch_template" "eks" {
  name_prefix   = "eks-${var.name}-"
  image_id      = data.aws_ssm_parameter.eks_ami.value
  instance_type = var.instance_type_1

  iam_instance_profile {
    name = aws_iam_instance_profile.eks.name
  }

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size = var.instance_volume_size
    }
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_put_response_hop_limit = 2
  }

  vpc_security_group_ids = concat(list(aws_security_group.eks_nodes.id), var.security_group_ids)

  user_data = base64encode(data.template_file.userdata.rendered)

  lifecycle {
    create_before_destroy = true
  }
}
