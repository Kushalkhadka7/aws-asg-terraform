output "generated_ssh_key_name" {
  value = join("", aws_key_pair.this.*.key_name)

  description = "Name of generated SSH key"
}

output "private_key" {
  value = join("", tls_private_key.this.*.private_key_pem)

  sensitive = true
}
