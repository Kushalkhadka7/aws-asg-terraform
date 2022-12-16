variable "launch_template_id" {
  type        = string
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

variable "name_space" {
  type        = string
  default     = "dev"
  description = "Workspce tag in which the auto scaling group will be created"
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
