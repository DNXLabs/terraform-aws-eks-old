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

<!--- END_TF_DOCS --->

## Author

Module managed by [DNX Solutions](https://github.com/DNXLabs).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/DNXLabs/terraform-aws-eks/blob/master/LICENSE) for full details.