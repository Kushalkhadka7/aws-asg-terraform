# Scale up policy for the auto scaling group.
resource "aws_autoscaling_policy" "scale_up" {
  name                   = var.scale_up_policy_name
  scaling_adjustment     = var.scale_up_scaling_adjustment
  adjustment_type        = var.scale_up_adjustemnt_type
  cooldown               = var.scale_up_cool_down
  policy_type            = var.scale_up_policy_type
  autoscaling_group_name = join("", aws_autoscaling_group.this.*.name)
}

resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  count               = 1
  alarm_name          = "${var.scale_up_policy_name}-cpu-utilization-high"
  comparison_operator = var.scale_up_comparison_operator != "" ? var.scale_up_comparison_operator : "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.cpu_utilization_high_evaluation_periods
  metric_name         = var.scale_up_metric_name != "" ? var.scale_up_metric_name : "CPUUtilization"
  namespace           = var.asg_scale_up_alaram_name_space
  period              = var.cpu_utilization_high_period_seconds
  statistic           = var.cpu_utilization_high_statistic
  threshold           = var.cpu_utilization_high_threshold_percent


  alarm_actions     = [join("", aws_autoscaling_policy.scale_up.*.arn)]
  alarm_description = "Scale up if cpu utilization is greater than or equals to specified threshold"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.this.*.name[count.index]
  }

}

# Scale down policy for the auto scaling group.
resource "aws_autoscaling_policy" "scale_down" {
  name                   = var.scale_down_policy_name
  scaling_adjustment     = var.scale_down_scaling_adjustment
  adjustment_type        = var.scale_down_adjustemnt_type
  cooldown               = var.scale_down_cool_down
  policy_type            = var.scale_down_policy_type
  autoscaling_group_name = join("", aws_autoscaling_group.this.*.name)
}


resource "aws_cloudwatch_metric_alarm" "cpu_low" {
  count               = 1
  alarm_name          = "${var.scale_down_policy_name}-cpu-utilization-low"
  comparison_operator = var.scale_down_comparison_operator != "" ? var.scale_down_comparison_operator : "LessThanOrEqualToThreshold"
  evaluation_periods  = var.cpu_utilization_low_evaluation_periods
  metric_name         = var.scale_down_metric_name != "" ? var.scale_down_metric_name : "CPUUtilization"
  namespace           = var.asg_scale_down_alaram_name_space
  period              = var.cpu_utilization_low_period_seconds
  statistic           = var.cpu_utilization_low_statistic
  threshold           = var.cpu_utilization_low_threshold_percent


  alarm_actions     = [join("", aws_autoscaling_policy.scale_down.*.arn)]
  alarm_description = "Scale down if the CPU utilization is below the specified threshold"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.this.*.name[count.index]
  }
}
