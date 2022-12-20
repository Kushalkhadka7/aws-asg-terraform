# Default variables
aws_region = "us-west-2"

# ----------------------------.
# Auto scaling gorup variables.
# ----------------------------.
vpc_id            = "vpc-02d927f1c4971893e"
aws_asg_name      = "test-asg"
name_space        = "dev"
min_size          = 1
max_size          = 3
health_check_type = "ELB"
desired_capacity  = 2
aws_subnets_ids   = ["subnet-0771cd4e71999289f", "subnet-0b31102b76a9d241a", "subnet-08e1ae2f26c9086df"]
target_group_arns = ["arn:aws:elasticloadbalancing:us-west-2:415873493245:targetgroup/test-tg/5c6d79dc2b62f57f"]

# --------------------------------------.
# Auto scaling `scale_up` configurations.
# --------------------------------------.
scale_up_policy_name = "test_scale_up_policy"

# --------------------------------------.
# Auto scaling `scale_down` configurations.
# --------------------------------------.
scale_down_policy_name = "test_scale_down_policy"

# Launch template configurations.
generate_new_ssh_key        = 1
ec2_ami_image_id            = "ami-0ecc74eca1d66d8a6"
existing_security_group_ids = ["sg-06a38c0d14abbe185"]
instance_type               = "t2.micro"
launch_template_name        = "test-launch-template"
launch_template_description = "Test launch template"
