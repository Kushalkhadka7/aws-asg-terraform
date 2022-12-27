output "launch_template_id" {
  value       = aws_launch_template.this[0].id
  description = "Id of the launch template which will be created"
}

output "launch_template_arn" {
  value       = aws_launch_template.this[0]
  description = "Arn of the launch template which will be created"
}

output "generated_ssh_key_name" {
  value       = module.key_pair_test.generated_ssh_key_name
  description = "Name of generated SSH key, which will be used on the launch template instances"
}

output "launch_template_security_group_id" {
  value       = local.should_create_default_sg > 0 ? aws_security_group.default.*.id : var.existing_security_group_ids
  description = "Id of the security group which will be attached to the ec2 instances"
}

output "launch_template_security_group_name" {
  value       = local.should_create_default_sg > 0 ? join("", aws_security_group.default.*.name) : ""
  description = "Name of the security group which will be attached to the ec2 instances"
}
