output "generated_ssh_key_name" {
  value = join("", aws_key_pair.this.*.key_name)

  description = "Name of generated SSH key"
}
