# terraform-aws-eks

[![Lint Status](https://github.com/DNXLabs/terraform-aws-eks/workflows/Lint/badge.svg)](https://github.com/DNXLabs/terraform-aws-eks/actions)
[![LICENSE](https://img.shields.io/github/license/DNXLabs/terraform-aws-eks)](https://github.com/DNXLabs/terraform-aws-eks/blob/master/LICENSE)

Terraform-aws-eks is a module that creates an Elastic Kubernetes Service(EKS) cluster with self-managed nodes.

 The following resources will be created:

- Auto Scaling
- CloudWatch log groups
- Security groups for EKS nodes
- 3 Instances for EKS Workers
   - instance_tye_1 - First Priority
   - instance_tye_2 - Second Priority
   - instance_tye_3 - Third Priority
- IAM roles and policies for EKS nodes

In addition you can:

- Set EC2 launch templates
- set Userdata

<!--- BEGIN_TF_DOCS --->

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.0 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| template | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| alarm\_sns\_topics | Alarm topics to create and alert on ECS instance metrics | `list` | `[]` | no |
| asg\_max | Max number of instances for autoscaling group | `number` | `4` | no |
| asg\_min | Min number of instances for autoscaling group | `number` | `1` | no |
| autoscaling\_default\_cooldown | The amount of time, in seconds, after a scaling activity completes before another scaling activity can start | `number` | `300` | no |
| autoscaling\_health\_check\_grace\_period | The length of time that Auto Scaling waits before checking an instance's health status. The grace period begins when an instance comes into service | `number` | `300` | no |
| cloudwatch\_logs\_retention | Specifies the number of days you want to retain log events in the specified log group. Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, and 3653. | `number` | `120` | no |
| instance\_type\_1 | Instance type for ECS workers (first priority) | `any` | n/a | yes |
| instance\_type\_2 | Instance type for ECS workers (second priority) | `any` | n/a | yes |
| instance\_type\_3 | Instance type for ECS workers (third priority) | `any` | n/a | yes |
| instance\_volume\_size | Volume size for docker volume (in GB) | `number` | `20` | no |
| name | Name of this ECS cluster | `any` | n/a | yes |
| on\_demand\_base\_capacity | You can designate a base portion of your total capacity as On-Demand. As the group scales, per your settings, the base portion is provisioned first, while additional On-Demand capacity is percentage-based. | `number` | `0` | no |
| on\_demand\_percentage | Percentage of on-demand intances vs spot | `number` | `100` | no |
| private\_subnet\_ids | List of private subnet IDs for ECS instances | `list` | n/a | yes |
| security\_group\_ids | Extra security groups for instances | `list` | `[]` | no |
| userdata | Extra commands to pass to userdata | `string` | `""` | no |
| vpc\_id | VPC ID to deploy the ECS cluster | `any` | n/a | yes |

## Outputs

No output.

<!--- END_TF_DOCS --->

## Author

Module managed by [DNX Solutions](https://github.com/DNXLabs).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/DNXLabs/terraform-aws-eks/blob/master/LICENSE) for full details.