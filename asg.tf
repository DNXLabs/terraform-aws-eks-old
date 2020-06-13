resource "aws_autoscaling_group" "eks" {
  name = "eks-${var.name}"

  mixed_instances_policy {
    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.eks.id
        version            = "$Latest"
      }

      override {
        instance_type = var.instance_type_1
      }

      override {
        instance_type = var.instance_type_2
      }

      override {
        instance_type = var.instance_type_3
      }
    }

    instances_distribution {
      spot_instance_pools                      = 3
      on_demand_base_capacity                  = var.on_demand_base_capacity
      on_demand_percentage_above_base_capacity = var.on_demand_percentage
    }
  }

  vpc_zone_identifier = var.private_subnet_ids

  min_size = var.asg_min
  max_size = var.asg_max

  tag {
    key                 = "Name"
    value               = "eks-node-${var.name}"
    propagate_at_launch = true
  }

  tag {
    key                 = "kubernetes.io/cluster/${aws_eks_cluster.default.name}"
    value               = "owned"
    propagate_at_launch = true
  }

  health_check_grace_period = var.autoscaling_health_check_grace_period
  default_cooldown          = var.autoscaling_default_cooldown

  lifecycle {
    create_before_destroy = true
  }
}

# resource "aws_autoscaling_policy" "ecs_memory_tracking" {
#   name                      = "eks-${var.name}-memory"
#   policy_type               = "TargetTrackingScaling"
#   autoscaling_group_name    = aws_autoscaling_group.eks.name
#   estimated_instance_warmup = "180"

#   target_tracking_configuration {
#     customized_metric_specification {
#       metric_dimension {
#         name  = "ClusterName"
#         value = aws_ecs_cluster.eks.name
#       }

#       metric_name = "MemoryReservation"
#       namespace   = "AWS/ECS"
#       statistic   = "Average"
#       unit        = "Percent"
#     }

#     target_value = var.asg_memory_target
#   }
# }
