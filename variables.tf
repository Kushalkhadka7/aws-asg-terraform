# For the creation of VPC.
variable "vpc_cidr" {
  type    = string
  default = ""
}

variable "vpc_name" {
  type    = string
  default = ""
}

# For the creation of private subnet.
variable "private_subnet_cidr" {
  default = ""
  type    = string
}

variable "public_subnet_cidr" {
  default = ""
  type    = string
}

# For the creation of public subnet.
variable "private_subnet_name" {
  default = ""
  type    = string
}

variable "public_subnet_name" {
  default = ""
  type    = string
}

# # For the creation of subnets.
variable "aws_availability_zones_available" {
  default = []
  type    = list(string)
}

# For Route tables.
variable "private_route_cidr" {
  default = ""
  type    = string
}


variable "public_route_cidr" {
  default = "0.0.0.0/0"
  type    = string
}

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


variable "ebs_device_name" {
  default = ""
  type    = string
}

variable "volume_type" {
  default = ""
  type    = string
}

variable "volume_size" {
  default = ""
  type    = string

}

variable "root_block_device_size" {
  default = ""
  type    = string
}

variable "root_block_device_type" {
  default = ""
  type    = string
}


variable "admin_asg_name" {
  default = ""
  type    = string
}

variable "autoscaling_group_name" {
  default = ""
  type    = string
}


# db variables
variable "engine" {
  default = ""
  type    = string
}

variable "storage_size" {
  default = 20
  type    = number
}

variable "storage_max" {
  default = 40
  type    = number
}

variable "apply_immediately" {
  default = false
  type    = bool
}

variable "backup_retention_period" {
  default = 7
  type    = number
}

variable "backup_window" {
  default = "04:00-05:00"
  type    = string
}

variable "maintenance_window" {
  default = "Mon:00:00-Mon:03:00"
  type    = string
}

variable "db_username" {
  default = ""
  type    = string
}

variable "dn_password" {
  default = ""
  type    = string
}

variable "engine_version" {
  default = ""
  type    = string
}

variable "subnet_group_name" {
  type    = string
  default = ""
}


variable "vpc_security_group_ids" {
  type    = list(string)
  default = []
}

variable "port" {
  type    = string
  default = "3306"
}


# Dynamo db

variable "table_name" {
  type    = string
  default = ""
}

variable "billing_mode" {
  type    = string
  default = ""
}

variable "read_capacity" {
  type    = number
  default = 1
}

variable "write_capacity" {
  type    = number
  default = 1
}

variable "hash_key" {
  type    = string
  default = ""
}

variable "range_key" {
  type    = string
  default = ""
}

variable "stream_enabled" {
  type    = bool
  default = false
}


variable "ttl_enabled" {
  type    = bool
  default = false
}

variable "hash_key_type" {
  type    = string
  default = ""
}

variable "range_key_type" {
  type    = string
  default = ""
}



# ALB
variable "name" {
  default = ""
  type    = string
}

variable "internal" {
  default = false
  type    = bool
}

variable "load_balancer_type" {
  default = ""
  type    = string
}

variable "security_groups" {
  default = []
  type    = list(string)
}

variable "cross_zone_load_balancing" {
  default = true
  type    = bool
}

variable "enable_http2" {
  default = false
  type    = bool
}

variable "enable_access_logs" {
  default = false
  type    = bool
}

variable "alb_logs_bucket_name" {
  default = "load_balancer"
  type    = string
}

variable "alb_logs_bucket_prefix" {
  default = "load_balancer/"
  type    = string
}

variable "alb_env" {
  default = "dev"
  type    = string
}

variable "alb_listener_port" {
  default = 80
  type    = number
}

variable "alb_listener_protocol" {
  default = "Http"
  type    = string
}


variable "route_path_pattern" {
  default = ["/admin/*"]
  type    = list(string)
}

variable "idle_timeout" {
  default = 400
  type    = number
}

variable "connection_draining" {
  default = true
  type    = bool
}

variable "connection_draining_timeout" {
  default = 400
  type    = number
}

variable "subnets" {
  default = []
  type    = list(string)
}

variable "enable_deletion_protection" {
  default = true
  type    = bool
}

# s3 bucket
variable "bucket_name" {
  default = ""
  type    = string
}

variable "bucket_acl" {
  default = ""
  type    = string
}

variable "env" {
  default = ""
  type    = string
}

variable "enabled_versioning" {
  default = false
  type    = bool
}


variable "policy" {
  default = ""
  type    = string
}


