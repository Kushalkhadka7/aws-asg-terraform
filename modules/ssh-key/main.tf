# Generates SSH key pairs that will be used for the underlying EC2 instances.
resource "tls_private_key" "this" {
  count = var.generate_new_ssh_key

  algorithm = var.algorithm
  rsa_bits  = var.rsa_bits
}

resource "aws_key_pair" "this" {
  count = var.generate_new_ssh_key

  key_name   = var.key_name
  public_key = tls_private_key.this
}

