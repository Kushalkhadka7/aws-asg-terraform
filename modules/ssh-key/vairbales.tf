variable "key_name" {
  type        = string
  default     = "defualt-key"
  description = "Name of the ssh key that will be created"
}

variable "rsa_bits" {
  type        = number
  default     = 4096
  description = "SSH key bits"
}

variable "algorithm" {
  type        = string
  default     = "RSA"
  description = "SSH key algorithm"
}

variable "generate_new_ssh_key" {
  type        = number
  default     = 0
  description = "Indicates either to generate SSH key pair or not"
}
