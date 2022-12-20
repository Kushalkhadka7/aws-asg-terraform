# Creates a placement group by which the underlying EC2 instances are distributed.
resource "aws_placement_group" "this" {
  count = var.placement_group_name != "" ? 1 : 0

  name     = var.placement_group_name
  strategy = var.placement_group_strategy
}

# Creates a launch template for the EC2 instances.
module "aws_ec2_launch_template" {
  source                               = "../ec2"
  vpc_id                               = var.vpc_id
  launch_template_id                   = var.launch_template_id
  launch_template_name                 = var.launch_template_name
  default_version                      = var.launch_template_version != "" ? var.launch_template_version : "$LATEST"
  name_space                           = var.name_space
  ec2_ami_image_id                     = var.ec2_ami_image_id
  launch_template_description          = var.launch_template_description
  disable_api_termination              = var.disable_api_termination
  ebs_optimized                        = var.ebs_optimized
  instance_initiated_shutdown_behavior = var.instance_initiated_shutdown_behavior
  instance_type                        = var.instance_type
  ssh_key_pair_name                    = var.ssh_key_pair_name
  user_data_base64                     = var.user_data_base64
  existing_iam_instance_profiles       = var.existing_iam_instance_profiles
  enable_monitoring                    = var.enable_monitoring
  associate_public_ip_address          = var.associate_public_ip_address
  existing_security_group_ids          = var.existing_security_group_ids
  placement                            = var.placement
  create_before_destroy                = var.create_before_destroy
  block_device_mappings                = var.block_device_mappings
}


# Creates an auto scaling group.
resource "aws_autoscaling_group" "this" {
  count                     = 1
  min_size                  = var.min_size
  max_size                  = var.max_size
  name                      = var.name_space != "" ? null : var.aws_asg_name
  name_prefix               = var.name_space != "" ? "${var.name_space}-${var.aws_asg_name}" : null
  health_check_type         = var.health_check_type != "" ? var.health_check_type : (var.target_group_arns != "" ? "ELB" : "EC2")
  health_check_grace_period = var.health_check_grace_period != "" ? var.health_check_grace_period : 300
  desired_capacity          = var.desired_capacity
  force_delete              = var.enable_force_delete
  placement_group           = var.placement_group_name != "" ? var.placement_group_name : (length(aws_placement_group.this) > 0 ? aws_placement_group.this.*.id[count.index] : null)
  vpc_zone_identifier       = var.aws_subnets_ids
  default_cooldown          = var.default_cooldown_period
  target_group_arns         = var.target_group_arns
  termination_policies      = var.termination_policies
  suspended_processes       = var.suspended_processes
  enabled_metrics           = var.enabled_metrics
  metrics_granularity       = var.metrics_granularity


  # User launch template to create underlying EC2 instances
  launch_template {
    id      = var.launch_template_id != "" ? var.launch_template_id : module.aws_ec2_launch_template.id
    version = "$Latest"
  }

  lifecycle {
    create_before_destroy = true
  }
}
