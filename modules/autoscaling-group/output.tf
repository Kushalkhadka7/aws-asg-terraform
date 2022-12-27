# -------------------------.
# Auto scaling group output.
# -------------------------.
output "auto_scaling_group_id" {
  value       = join("", aws_autoscaling_group.this.*.id)
  description = "Id of the created auto scaling group"
}

output "auto_scaling_group_arn" {
  value       = join("", aws_autoscaling_group.this.*.arn)
  description = "Arn of the created auto scaling group"
}

output "auto_scaling_group_name" {
  value       = join("", aws_autoscaling_group.this.*.name)
  description = "Name of the created auto scaling group"
}

output "ec2_placement_group_name" {
  value       = var.placement_group_name == "" ? join("", aws_placement_group.this.*.name) : var.placement_group_name
  description = "Name of the created auto scaling group"
}

# ----------------------.
# Launch template output.
# ----------------------.
output "launch_template_id" {
  value       = module.aws_ec2_launch_template.launch_template_id
  description = "Id of the launch template which will be created"
}

output "launch_template_arn" {
  value       = module.aws_ec2_launch_template.launch_template_arn
  description = "Arn of the launch template which will be created"
}

output "generated_ssh_key_name" {
  value       = module.aws_ec2_launch_template.generated_ssh_key_name
  description = "Name of generated SSH key, which will be used on the launch template instances"
}

output "launch_template_security_group_id" {
  value       = module.aws_ec2_launch_template.launch_template_security_group_id
  description = "Id of the security group which will be attached to the ec2 instances"
}

output "launch_template_security_group_name" {
  value       = module.aws_ec2_launch_template.launch_template_security_group_name
  description = "Name of the security group which will be attached to the ec2 instances"
}
