# Default variables
aws_region = "us-west-2"

# ----------------------------.
# Auto scaling gorup variables.
# ----------------------------.
vpc_id            = "vpc-002238ffdac78eb94"
aws_asg_name      = "test-asg"
name_space        = "dev"
min_size          = 1
max_size          = 3
health_check_type = "ELB"
desired_capacity  = 2
aws_subnets_ids   = ["subnet-0c41877fcfee2e047", "subnet-01c17a758ddf0c4f5", "subnet-0186ade5b85a81d59", "subnet-01fc73338fc139a4f"]
target_group_arns = ["arn:aws:elasticloadbalancing:us-west-2:415873493245:targetgroup/test-tg/f5c4b543f4e79435"]

# --------------------------------------.
# Auto scaling `scale_up` configurations.
# --------------------------------------.
scale_up_policy_name = "test_scale_up_policy"

# --------------------------------------.
# Auto scaling `scale_down` configurations.
# --------------------------------------.
scale_down_policy_name = "test_scale_down_policy"

# Launch template configurations.
ec2_ami_image_id            = "ami-0ecc74eca1d66d8a6"
existing_security_group_ids = ["sg-09249895ad24d5289"]
instance_type               = "t3.medium"
launch_template_name        = "test-launch-template"
launch_template_description = "Test launch template"
ssh_key_pair_name           = "test"
