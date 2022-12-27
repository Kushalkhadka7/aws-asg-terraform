# Default
variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags that will be attached to the launch template"
}

# ----------------------------.
# Auto scaling group variables.
# ----------------------------.
variable "placement_group_name" {
  type        = string
  default     = ""
  description = "Name of the placement group for the underlying EC2 instances in asg"
}

variable "name_prefix" {
  type        = string
  default     = "dev"
  description = "Name of the placement group for the underlying EC2 instances in asg"
}

variable "placement_group_strategy" {
  type        = string
  default     = "cluster"
  description = "Aws placement gorup strategy."
}

variable "aws_asg_name" {
  type        = string
  nullable    = false
  description = "Aws auto scaling group name.(Required)"
}

variable "name_space" {
  type        = string
  default     = "dev"
  description = "Workspce tag in which the auto scaling group will be created"
}

variable "min_size" {
  type        = number
  default     = 1
  description = "Mininum number instances in the auto scaling group"
}

variable "max_size" {
  type        = number
  default     = 1
  description = "Maxminum number instances in the auto scaling group"
}

variable "health_check_type" {
  default     = ""
  type        = string
  description = "Health check type for the underlying EC2 instances.(ELB or EC2)"
}

variable "health_check_grace_period" {
  default     = 300
  type        = number
  description = "Health check interval for the underlying EC2 instances"
}

variable "desired_capacity" {
  type = number
  # [NOTE]: `desire_capacity` should be less than or equals to `max_size` and greater than or equals to `min_size`
  default     = 1
  description = "Desired number instances currently running in the auto scaling group"
}

variable "enable_force_delete" {
  type        = bool
  default     = false
  description = "Auto scaling group will be deleted withouth waiting the underlying EC2 instandces to terminate."
}

variable "aws_subnets_ids" {
  type        = list(string)
  default     = []
  description = "List of subnets where we want to launch the aws autoscaling group"
}

variable "default_cooldown_period" {
  type        = number
  default     = 200
  description = "Cool down period time in seconds"
}

variable "target_group_arns" {
  type        = list(string)
  default     = []
  description = "Aws target group arn, usesd to attach autoscaling group to a target group"
}

variable "termination_policies" {
  description = "A list of policies to decide how the instances in the auto scale gets terminated"
  type        = list(string)
  default     = ["Default"]
}

variable "suspended_processes" {
  type        = list(string)
  description = "A list of processes to suspend for the AutoScaling Group. The allowed values are `Launch`, `Terminate`, `HealthCheck`, `ReplaceUnhealthy`, `AZRebalance`, `AlarmNotification`, `ScheduledActions`, `AddToLoadBalancer`. Note that if you suspend either the `Launch` or `Terminate` process types, it can prevent your autoscaling group from functioning properly."
  default     = []
}

variable "enabled_metrics" {
  description = "List of metrics to collect from the auto scaling group instances"
  type        = list(string)

  default = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupTotalInstances",
    "GroupDesiredCapacity",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupInServiceInstances",
    "GroupTerminatingInstances",
  ]
}

variable "launch_template_version" {
  type        = string
  default     = "$LATEST"
  description = "Aws launch template version"
}


variable "metrics_granularity" {
  type        = string
  description = "The granularity to associate with the metrics to collect."
  default     = "1Minute"
}

variable "asg_key" {
  type        = string
  default     = "DEFAULT_ASG"
  description = "Asg key to be attached as tag"
}


variable "default_instance_warmup" {
  type        = number
  default     = 120
  description = " Amount of time, in seconds, until a newly launched instance can contribute to the Amazon CloudWatch metrics"
}

variable "service_linked_role_arn" {
  type        = string
  default     = ""
  description = "ARN of the service-linked role that the ASG will use to call other AWS services"
}

variable "instance_refresh" {
  type = object({
    strategy               = string
    min_healthy_percentage = number
    triggers               = list(string)
  })

  default     = null
  description = "The instnce_refreh specifications of the instances in auto scaling group"
}


# --------------------------------------.
# Auto scaling `scale_up` configurations.
# --------------------------------------.
variable "scale_up_policy_name" {
  type        = string
  default     = "default_scale_up_policy"
  description = "Name of auto scaling group scale up policy"
}

variable "scale_up_scaling_adjustment" {
  type        = number
  default     = 1
  description = "Number of instances by which to scale up"
}

variable "scale_up_adjustemnt_type" {
  type    = string
  default = "ChangeInCapacity"
  # Valid values are ChangeInCapacity, ExactCapacity, and PercentChangeInCapacity.
  description = "Whether the adjustment is an absolute number or a percentage of the current capacity"
}

variable "scale_up_cool_down" {
  type        = number
  default     = 300
  description = "Amount of time, in seconds, after a scaling activity completes and before the next scaling activity can start."
}

variable "scale_up_policy_type" {
  type    = string
  default = "SimpleScaling"
  # Valid values are "SimpleScaling", "StepScaling", "TargetTrackingScaling", or "PredictiveScaling"
  description = "Auto scaling group scaling type"
}


# ---------------------------------------------.
# Auto scaling `scale_up alaram` configurations.
# ---------------------------------------------.
variable "scale_up_comparison_operator" {
  type        = string
  default     = "GreaterThanOrEqualToThreshold"
  description = "Comparison to the threshold specified"
  # Valid values are:
  # - GreaterThanOrEqualToThreshold
  # - GreaterThanThreshold
}

variable "asg_scale_up_alaram_name_space" {
  type        = string
  default     = "AWS/EC2"
  description = "Name space in which auto "
}

variable "cpu_utilization_high_evaluation_periods" {
  type        = string
  default     = "1"
  description = "The number of periods over which data is compared to the specified threshold."
}

variable "cpu_utilization_high_period_seconds" {
  type        = string
  default     = "120"
  description = "The period in seconds over which the specified statistic is applied"
}

variable "cpu_utilization_high_statistic" {
  type    = string
  default = "Average"
  # Valid values: SampleCount, Average, Sum, Minimum, Maximum.
  description = "The statistic to apply to the alarm's associated metric."
}

variable "cpu_utilization_high_threshold_percent" {
  type        = string
  default     = "80"
  description = "The value against which the specified statistic is compared"
}

# --------------------------------------.
# Auto scaling `scale_up` configurations.
# --------------------------------------.
variable "scale_up_metric_name" {
  type        = string
  default     = "CPUUtilization"
  description = "Metric to look for scale up."
}

variable "scale_down_policy_name" {
  type        = string
  default     = "default_scale_down_policy"
  description = "Name of auto scaling group scale down policy"
}

variable "scale_down_scaling_adjustment" {
  type        = number
  default     = 1
  description = "Number of instances by which to scale down"
}

variable "scale_down_adjustemnt_type" {
  type    = string
  default = "ChangeInCapacity"
  # Valid values: ChangeInCapacity, ExactCapacity, and PercentChangeInCapacity.
  description = "Whether the adjustment is an absolute number or a percentage of the current capacity"
}

variable "scale_down_cool_down" {
  type        = number
  default     = 300
  description = "Amount of time, in seconds, after a scaling activity completes and before the next scaling activity can start."
}

variable "scale_down_policy_type" {
  type    = string
  default = "SimpleScaling"
  # Valid values are "SimpleScaling", "StepScaling", "TargetTrackingScaling", or "PredictiveScaling"
  description = "Auto scaling group scaling type"
}

# -----------------------------------------------.
# Auto scaling `scale_down alaram` configurations.
# -----------------------------------------------.
variable "asg_scale_down_alaram_name_space" {
  type        = string
  default     = "AWS/EC2"
  description = "Name space in which auto "
}

variable "scale_down_comparison_operator" {
  type        = string
  default     = "LessThanOrEqualToThreshold"
  description = "Comparison to the threshold specified"
  # Valid values are:
  # - LessThanThreshold, 
  # - LessThanOrEqualToThreshold
}

variable "cpu_utilization_low_evaluation_periods" {
  type        = string
  default     = 1
  description = "The number of periods over which data is compared to the specified threshold."

}

variable "cpu_utilization_low_period_seconds" {
  type        = string
  default     = "120"
  description = "The period in seconds over which the specified statistic is applied"
}

variable "cpu_utilization_low_statistic" {
  type    = string
  default = "Average"
  # Valid values: SampleCount, Average, Sum, Minimum, Maximum.
  description = "The statistic to apply to the alarm's associated metric."
}

variable "cpu_utilization_low_threshold_percent" {
  type        = string
  default     = "80"
  description = "The value against which the specified statistic is compared"
}

variable "scale_down_metric_name" {
  type        = string
  default     = "CPUUtilization"
  description = "Metric to look for scale up."
}

# -------------------------.
# Launch template variables.
# -------------------------.
variable "launch_template_id" {
  type        = string
  default     = ""
  description = "Name of the launch template that is being created"
}

variable "launch_template_name" {
  type        = string
  description = "Name of the launch template that is being created"
}

variable "launch_template_description" {
  type        = string
  default     = ""
  description = "Description for the launch template"
}

variable "default_version" {
  type        = string
  default     = "$LATEST"
  description = "Default version of the launch template"
}

variable "ec2_ami_image_id" {
  default     = ""
  type        = string
  description = "The EC2 image ID to launch"
}

variable "disable_api_termination" {
  type        = bool
  default     = false
  description = "This enables EC2 Instance Termination Protection"
}

variable "ebs_optimized" {
  type        = bool
  default     = false
  description = "Launched EC2 instance by using this template will be EBS-optimized"
}

variable "instance_initiated_shutdown_behavior" {
  type        = string
  default     = "terminate"
  description = "Shutdown behavior for the instances"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "Instance type to launch"
}

variable "ssh_key_pair_name" {
  type        = string
  default     = ""
  description = "The SSH key name that should be used for the instance"
}

variable "user_data_base64" {
  type        = string
  default     = ""
  description = "User data for the EC2 instances"
}

variable "existing_iam_instance_profiles" {
  type        = list(string)
  default     = []
  description = "List of  IAM instance profile names to associate with launched instances"
}

variable "enable_monitoring" {
  default     = false
  type        = bool
  description = "Enable detail monitoring for the EC2 instances.This may cost more"
}

variable "associate_public_ip_address" {
  default     = false
  type        = bool
  description = "Associate public ip to the EC2 instances"
}

variable "existing_security_group_ids" {
  type        = list(string)
  default     = []
  description = "Security group ids for the EC2 instances"
}

variable "placement" {
  type = object({
    affinity          = string
    availability_zone = string
    group_name        = string
    host_id           = string
    tenancy           = string
  })

  default     = null
  description = "The placement specifications of the instances"
}

variable "create_before_destroy" {
  default     = true
  type        = bool
  description = "Life cycle policy"
}

variable "block_device_mappings" {
  description = "Specify volumes to attach to the instance besides the volumes specified by the AMI"

  type = list(object({
    device_name  = string
    no_device    = bool
    virtual_name = string
    ebs = object({
      delete_on_termination = bool
      encrypted             = bool
      iops                  = number
      kms_key_id            = string
      snapshot_id           = string
      volume_size           = number
      volume_type           = string
    })
  }))

  default = []
}

variable "instance_market_options" {
  description = "Purchasing options for ec2 instances from market"

  type = object({
    market_type = string
    spot_options = object({
      block_duration_minutes         = bool
      instance_interruption_behavior = string
      max_price                      = number
      spot_instance_type             = string
      valid_until                    = string
    })
  })

  default = null
}

variable "network_interfaces_description" {
  type        = string
  default     = ""
  description = "Description for EC2 network interfaces"
}

variable "vpc_id" {
  type        = string
  description = "Current vpc id in which resources will be created"
}

variable "additional_launch_template_tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags that will be attached to the launch template"
}

# ---------------------.
# SSH key pair variables.
# ----------------------.
variable "key_name" {
  type        = string
  default     = "defualt-key"
  description = "Name of the ssh key that will be created"
}

variable "rsa_bits" {
  type        = number
  default     = 4096
  description = "SSH key bits"
}

variable "algorithm" {
  type        = string
  default     = "RSA"
  description = "SSH key algorithm"
}

variable "generate_new_ssh_key" {
  type        = number
  default     = 0
  description = "Indicates either to generate SSH key pair or not"
}
