# Metrics to scale down the auto scaling group.
resource "aws_autoscaling_policy" "default_scale_down" {
  name                   = var.scale_down_policy_name
  scaling_adjustment     = var.scale_down_scaling_adjustment
  adjustment_type        = var.scale_down_adjustemnt_type
  cooldown               = var.scale_down_cool_down
  policy_type            = var.scale_down_policy_type
  for_each               = aws_autoscaling_group.default
  autoscaling_group_name = each.key
}
