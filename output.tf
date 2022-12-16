
output "generated_ssh_key_name" {
  value = module.auto_scaling_group.generated_ssh_key_name

  description = "Name of generated SSH key"
}
