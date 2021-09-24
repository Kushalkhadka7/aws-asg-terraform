variable "scale_up_policy_name" {
  default = ""
  type    = string
}

variable "scale_up_scaling_adjustment" {
  default = 3
  type    = number
}

variable "scale_up_adjustemnt_type" {
  default = ""
  type    = string
}

variable "scale_up_cool_down" {
  default = 300
  type    = number
}

variable "scale_up_policy_type" {
  default = ""
  type    = string
}

variable "auto_scaling_group_name" {
  default = ""
  type    = string
}

variable "scale_down_policy_name" {
  default = ""
  type    = string
}

variable "scale_down_scaling_adjustment" {
  default = 1
  type    = number
}

variable "scale_down_adjustemnt_type" {
  default = ""
  type    = string
}

variable "scale_down_cool_down" {
  default = 300
  type    = number
}

variable "scale_down_policy_type" {
  default = ""
  type    = string
}

variable "asg_name" {
  default = ""
  type    = string
}

variable "availability_zones" {
  default = []
  type    = list(string)
}

variable "min_size" {
  default = 1
  type    = number
}

variable "max_size" {
  default = 6
  type    = number
}

variable "health_check_type" {
  default = ""
  type    = string
}

variable "health_check_grace_period" {
  default = ""
  type    = string
}

variable "desired_capacity" {
  default = 1
  type    = number
}

variable "launch_configurations_namevariable" {
  default = ""
  type    = string
}

variable "ec2_image_id" {
  default = ""
  type    = string
}

variable "ec2_instance_type" {
  default = ""
  type    = string
}

variable "ec2_security_groups" {
  default = []
  type    = list(string)
}

variable "enable_monitoring" {
  default = false
  type    = bool
}

variable "ebs_optimized" {
  default = false
  type    = bool
}

variable "delete_on_termination" {
  default = false
  type    = bool
}




variable "ebs_device_name" {
  default = ""
  type    = string
}



variable "root_block_device_size" {
  type    = string
  default = "50" # This needs to be stirng not 50.
}

variable "root_block_device_type" {
  default = "gp2"
  type    = string
}


variable "autoscaling_group_name" {
  default = ""
  type    = string
}


variable "subnets_ids" {
  type = any
}


# New added.

variable "default_cooldown_period" {
  type    = number
  default = 300
}



variable "asg_key" {
  type    = string
  default = "foo"
}


variable "asg_value" {
  type    = string
  default = "bar"
}


variable "propagate_at_launch" {
  type    = bool
  default = true
}



variable "create_before_destroy" {
  type    = bool
  default = true
}



variable "ebs_volume_size" {
  type    = string
  default = "50" # This needs to be stirng not 50.
}


variable "ebs_volume_type" {
  type    = string
  default = "gp2"
}
