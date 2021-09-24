terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "test_asg" {
  source                    = "./asg"
  subnets_ids               = data.aws_vpc.selected.id
  asg_name                  = var.admin_asg_name
  min_size                  = var.min_size
  max_size                  = length(data.aws_availability_zones.available.names) * 2
  health_check_type         = var.health_check_type
  health_check_grace_period = var.health_check_grace_period
  desired_capacity          = length(data.aws_availability_zones.available.names)
  default_cooldown_period   = var.default_cooldown_period
  asg_key                   = var.asg_key
  asg_value                 = var.asg_value
  propagate_at_launch       = var.propagate_at_launch
  create_before_destroy     = var.create_before_destroy

  # launch configurations.
  ec2_image_id           = "ami-04d29b6f966df1537"
  ec2_instance_type      = var.ec2_instance_type
  ec2_security_groups    = [aws_security_group.ec2_security_group.id]
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
