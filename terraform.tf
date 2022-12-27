terraform {
  required_version = "~> 1.3.4"

  required_providers {
    aws      = "~> 4.48.0"
    template = "~> 2.0"
    null     = "~> 2.0"
    local    = "~> 1.3"
    tls      = "~> 2.1"
  }
}
