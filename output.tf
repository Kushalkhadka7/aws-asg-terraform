
output "generated_ssh_key_name" {
  value = module.auto_scaling_group.generated_ssh_key_name

  description = "Name of generated SSH key"
}

output "private_key" {
  value = module.auto_scaling_group.private_key

  sensitive = true
}

output "user_data_info" {
  value = module.auto_scaling_group.user_data_info
}
