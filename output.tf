
output "generated_ssh_key_name" {
  value = module.auto_scaling_group.generated_ssh_key_name

  description = "Name of generated SSH key"
}

output "private_key" {
  value = module.auto_scaling_group.private_key

  sensitive = true
}
