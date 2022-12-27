locals {
  asg_name        = var.name_space != "" ? null : var.aws_asg_name
  asg_name_prefix = var.name_space != "" ? "${var.name_space}-${var.aws_asg_name}" : null

  asg_health_check_period = var.health_check_grace_period != "" ? var.health_check_grace_period : 300
  asg_health_check_type   = var.health_check_type != "" ? var.health_check_type : (var.target_group_arns != "" ? "ELB" : "EC2")

  ec2_launch_template_version = var.launch_template_version != "" ? var.launch_template_version : "$LATEST"
  ec2_launch_template_id      = var.launch_template_id != "" ? var.launch_template_id : module.aws_ec2_launch_template.launch_template_id
}

# Creates a placement group by which the underlying EC2 instances are distributed.
resource "aws_placement_group" "this" {
  count = var.placement_group_name != "" ? 1 : 0

  name     = var.placement_group_name
  strategy = var.placement_group_strategy
}

# Creates a launch template for the EC2 instances.
module "aws_ec2_launch_template" {
  source = "../ec2"

  tags                                 = var.tags
  vpc_id                               = var.vpc_id
  placement                            = var.placement
  name_space                           = var.name_space
  instance_type                        = var.instance_type
  ebs_optimized                        = var.ebs_optimized
  user_data_base64                     = var.user_data_base64
  ec2_ami_image_id                     = var.ec2_ami_image_id
  enable_monitoring                    = var.enable_monitoring
  ssh_key_pair_name                    = var.ssh_key_pair_name
  launch_template_id                   = var.launch_template_id
  launch_template_name                 = var.launch_template_name
  block_device_mappings                = var.block_device_mappings
  create_before_destroy                = var.create_before_destroy
  disable_api_termination              = var.disable_api_termination
  associate_public_ip_address          = var.associate_public_ip_address
  existing_security_group_ids          = var.existing_security_group_ids
  launch_template_description          = var.launch_template_description
  default_version                      = local.ec2_launch_template_version
  existing_iam_instance_profiles       = var.existing_iam_instance_profiles
  additional_launch_template_tags      = var.additional_launch_template_tags
  instance_initiated_shutdown_behavior = var.instance_initiated_shutdown_behavior
}


# Creates an auto scaling group.
resource "aws_autoscaling_group" "this" {
  count = 1

  min_size                  = var.min_size
  max_size                  = var.max_size
  name                      = local.asg_name
  enabled_metrics           = var.enabled_metrics
  vpc_zone_identifier       = var.aws_subnets_ids
  desired_capacity          = var.desired_capacity
  target_group_arns         = var.target_group_arns
  name_prefix               = local.asg_name_prefix
  suspended_processes       = var.suspended_processes
  metrics_granularity       = var.metrics_granularity
  force_delete              = var.enable_force_delete
  termination_policies      = var.termination_policies
  service_linked_role_arn   = var.service_linked_role_arn
  default_instance_warmup   = var.default_instance_warmup
  health_check_type         = local.asg_health_check_type
  default_cooldown          = var.default_cooldown_period
  health_check_grace_period = local.asg_health_check_period
  placement_group           = var.placement_group_name != "" ? var.placement_group_name : (length(aws_placement_group.this) > 0 ? aws_placement_group.this.*.id[count.index] : null)


  # User launch template to create underlying EC2 instances
  launch_template {
    id      = local.ec2_launch_template_id
    version = "$Latest"
  }

  lifecycle {
    create_before_destroy = true
  }


  dynamic "instance_refresh" {
    for_each = var.instance_refresh != null ? [var.instance_refresh] : []

    content {
      strategy = lookup(instance_refresh.value, "strategy", null)
      preferences {
        min_healthy_percentage = lookup(instance_refresh.value, "min_healthy_percentage", 50)
      }

      triggers = [lookup(instance_refresh.value, "triggers", "")]
    }
  }

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }

  }
}
