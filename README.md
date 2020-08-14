# terraform-aws-eks

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
