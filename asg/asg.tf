# Creates a auto scaling group with given name and no of instances.
resource "aws_autoscaling_group" "default" {
  name                      = var.asg_name
  min_size                  = var.min_size
  max_size                  = var.max_size
  health_check_type         = var.health_check_type
  health_check_grace_period = var.health_check_grace_period
  desired_capacity          = var.desired_capacity
  vpc_zone_identifier       = var.subnets_ids
  default_cooldown          = var.default_cooldown_period
  launch_configuration      = aws_launch_configuration.default.name

  tag {
    key                 = var.asg_key
    value               = var.asg_value
    propagate_at_launch = var.propagate_at_launch
  }
}
