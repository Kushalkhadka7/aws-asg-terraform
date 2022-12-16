# resource "aws_security_group" "elb_security_group" {
#   name        = "elb_security_group"
#   description = "Allow traffic from outside the web."
#   vpc_id      = module.aws_vpc.default_vpc.id

#   tags = {
#     Name = "elb_security_group"
#   }

#   ingress {
#     description = "TLS from VPC"
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = [module.aws_vpc.default_vpc.cidr_block]
#   }
# }


# resource "aws_security_group" "asg_security_group" {
#   name        = "asg_security_group"
#   description = "Allow traffic only from elastic load balancer"
#   vpc_id      = module.aws_vpc.default_vpc.id

#   tags = {
#     Name = "asg_security_group"
#   }

#   ingress {
#     description = "TLS from VPC"
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = [module.aws_vpc.default_vpc.cidr_block]
#   }
# }

# resource "aws_security_group" "ec2_security_group" {
#   name        = "ec2_security_group"
#   description = "Allow traffic only from auto scaling group"
#   vpc_id      = module.aws_vpc.default_vpc.id
#   tags = {
#     Name = "asg_security_group"
#   }

#   ingress {
#     description = "TLS from VPC"
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = [module.aws_vpc.default_vpc.cidr_block]
#   }
# }


