# AWS Auto Scaling Group (ASG)

Terraform module which creates Auto Scaling Group (ASG).
Initializes a ASG along with scale up and scale down policies.

## Diagram

![Architecture Diagram](assets/asg.png)

## Requirements

| Name      | Version   |
| --------- | --------- |
| terraform | >= 1.3.4  |
| aws       | >= 4.48.0 |

## Providers

| Name | Version   |
| ---- | --------- |
| aws  | >= 4.48.0 |

| Phase    | Equivalent `Terraform` Command                                  |
| -------- | --------------------------------------------------------------- |
| Planning | `make terraform-plan` **or** `make docker/terraform-plan`       |
| Creation | `make terraform-apply` **or** `make docker/terraform-apply`     |
| Update   | `make terraform-apply` **or** `make docker/terraform-apply`     |
| Deletion | `make terraform-destroy` **or** `make docker/terraform-destroy` |

## Usage

```hcl
module "admin_asg" {
  source                    = "./asg"
  asg_name                  = var.admin_asg_name
  min_size                  = var.min_size
  max_size                  = length(data.aws_availability_zones.available.names) * 2
  health_check_type         = var.health_check_type
  health_check_grace_period = var.health_check_grace_period
  subnets                   = module.aws_vpc.private_subnet.ids
  desired_capacity          = length(data.aws_availability_zones.available.names)
  default_cooldown_period   = var.default_cooldown_period
  key                       = var.asg_key
  value                     = var.asg_value
  propagate_at_launch       = var.propagate_at_launch
  create_before_destroy     = var.create_before_destroy

  # launch configurations.
  ec2_image_id           = "ami-04d29b6f966df1537"
  ec2_instance_type      = var.ec2_instance_type
  existing_security_group_ids    = [aws_security_group.ec2_security_group.id]
  enable_monitoring      = var.enable_monitoring
  ebs_optimized          = var.ebs_optimized
  ebs_device_name        = var.ebs_device_name
  ebs_volume_type        = var.ebs_volume_type
  ebs_volume_size        = var.ebs_volume_size
  delete_on_termination  = var.delete_on_termination
  root_block_device_size = var.root_block_device_size
  root_block_device_type = var.root_block_device_type

  # Scale down policy.
  scale_down_policy_name        = var.scale_down_policy_name
  scale_down_scaling_adjustment = var.scale_down_scaling_adjustment
  scale_down_adjustemnt_type    = var.scale_down_adjustemnt_type
  scale_down_cool_down          = var.scale_down_cool_down
  scale_down_policy_type        = var.scale_down_policy_type

  # Scale up policy.
  scale_up_policy_name        = var.scale_up_policy_name
  scale_up_scaling_adjustment = var.scale_up_scaling_adjustment
  scale_up_adjustemnt_type    = var.scale_up_adjustemnt_type
  scale_up_cool_down          = var.scale_up_cool_down
  scale_up_policy_type        = var.scale_up_policy_type
}
```

## Inputs

```
 "scale_up_policy_name"  string

 "scale_up_scaling_adjustment"  number

 "scale_up_adjustemnt_type"  string

 "scale_up_cool_down"  number

 "scale_up_policy_type"  string

 "auto_scaling_group_name"  string

 "scale_down_policy_name"  string

 "scale_down_scaling_adjustment"  number

 "scale_down_adjustemnt_type"  string

 "scale_down_cool_down"  number

 "scale_down_policy_type"  string

 "asg_name" string

 "availability_zones"  list(string)

 "min_size"  number

 "max_size"  number

 "health_check_type"  string

 "health_check_grace_period"  string

 "desired_capacity"  number

 "launch_configurations_name"  string

 "ec2_image_id"  string

 "ec2_instance_type"  string

 "existing_security_group_ids"  list(string)

 "enable_monitoring"  bool

 "ebs_optimized"  bool

 "delete_on_termination"  bool

 "ebs_device_name"  string

 "root_block_device_size" string eg. "50" # This needs to be stirng not 50.

 "root_block_device_type"  string

 "autoscaling_group_name"  string

 "subnets_ids" list(number)

 "default_cooldown_period"  number

 "asg_key" string

 "asg_value" string

 "propagate_at_launch"  bool

 "create_before_destroy"  bool

 "ebs_volume_size" string eg. "50" # This needs to be stirng not 50.

 "ebs_volume_type"  string

 "ebs_device_name"  string
```

**NOTE : `terraform.tfvars` file should be created and the above used variables should be initialized it the file.**

## Running locally.

- Make copy of the `terraform.tfvars.example` to `terraform.tfvars` file
- Update the variables as required.
- export `AWS_REGION`, `AWS_ACCESS_KEY_ID` and `AWS_SECRET_KEY` on the terminal.
  ```
  export AWS_REGION=us-east-1
  export AWS_ACCESS_KEY_ID= xxxxxxxxxxxxx
  export AWS_SECRET_KEY= xxxxxxxxxxxxxxx
  ```
- Build the docker image locally
  ```
  make docker-build
  ```
- Run terraform commands

  ```
  # Initialize terraform.

  make terraform-init
  make docker/terraform-init # using docker

  # Show resources to be created.

  make terraform-plan
  make docker/terraform-plan # using docker

  # Create resources.

  make terraform-apply
  make terraform/terraform-apply # using docker

  ```
