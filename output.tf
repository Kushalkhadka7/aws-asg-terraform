# -------------------------.
# Auto scaling group output.
# -------------------------.
output "auto_scaling_group_id" {
  value       = module.auto_scaling_group.auto_scaling_group_id
  description = "Id of the created auto scaling group"
}

output "auto_scaling_group_arn" {
  value       = module.auto_scaling_group.auto_scaling_group_arn
  description = "Arn of the created auto scaling group"
}

output "auto_scaling_group_name" {
  value       = module.auto_scaling_group.auto_scaling_group_name
  description = "Name of the created auto scaling group"
}

output "ec2_placement_group_name" {
  value       = module.auto_scaling_group.ec2_placement_group_name
  description = "Name of the created auto scaling group"
}

# ----------------------.
# Launch template output.
# ----------------------.
output "launch_template_id" {
  value       = module.auto_scaling_group.launch_template_id
  description = "Id of the launch template which will be created"
}

output "launch_template_arn" {
  value       = module.auto_scaling_group.launch_template_arn
  description = "Arn of the launch template which will be created"
}

output "generated_ssh_key_name" {
  value       = module.auto_scaling_group.generated_ssh_key_name
  description = "Name of generated SSH key, which will be used on the launch template instances"
}

output "launch_template_security_group_id" {
  value       = module.auto_scaling_group.launch_template_security_group_id
  description = "Id of the security group which will be attached to the ec2 instances"
}

output "launch_template_security_group_name" {
  value       = module.auto_scaling_group.launch_template_security_group_name
  description = "Name of the security group which will be attached to the ec2 instances"
}
