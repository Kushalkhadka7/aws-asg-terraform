output "id" {
  value       = aws_launch_template.this[0].id
  description = "Auto scaling goup name"
}

output "ec2" {
  value       = aws_launch_template.this[0]
  description = "Auto scaling goup id"
}

output "generated_ssh_key_name" {
  value = module.key_pair_test.generated_ssh_key_name

  description = "Name of generated SSH key"
}

output "private_key" {
  value = module.key_pair_test.private_key

  sensitive = true
}
