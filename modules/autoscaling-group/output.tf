output "generated_ssh_key_name" {
  value = module.aws_ec2_launch_template.generated_ssh_key_name

  description = "Name of generated SSH key"
}

output "id" {
  value       = module.aws_ec2_launch_template.id
  description = "Auto scaling goup name"
}

output "ec2" {
  value       = module.aws_ec2_launch_template
  description = "Auto scaling goup id"
}

output "private_key" {
  value = module.aws_ec2_launch_template.private_key

  sensitive = true
}
