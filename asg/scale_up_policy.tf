# Metrics to scale up the auto scaling group.
resource "aws_autoscaling_policy" "default_scale_up" {
  name                   = var.scale_up_policy_name
  scaling_adjustment     = var.scale_up_scaling_adjustment
  adjustment_type        = var.scale_up_adjustemnt_type
  cooldown               = var.scale_up_cool_down
  policy_type            = var.scale_up_policy_type
  for_each               = aws_autoscaling_group.default
  autoscaling_group_name = each.key
}
