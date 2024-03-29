module "auto_scaling_group" {
  source = "./modules/autoscaling-group"

  # ---------------------------.
  # Auto scaling group variables.
  # ----------------------------.
  vpc_id                         = var.vpc_id
  min_size                       = var.min_size
  max_size                       = var.max_size
  name_space                     = var.name_space
  aws_asg_name                   = var.aws_asg_name
  aws_subnets_ids                = var.aws_subnets_ids
  desired_capacity               = var.desired_capacity
  user_data_base64               = var.user_data_base64
  health_check_type              = var.health_check_type
  target_group_arns              = var.target_group_arns
  default_cooldown_period        = var.default_cooldown_period
  existing_iam_instance_profiles = var.existing_iam_instance_profiles

  # -------------------------.
  # Scale up policy variables.
  # -------------------------.
  scale_up_policy_name = var.scale_up_policy_name

  # -------------------------.
  # Scale down policy variables.
  # -------------------------.
  scale_down_policy_name = var.scale_down_policy_name


  # ------------------------------.
  # Launch template configurations.
  # ------------------------------.
  instance_type               = var.instance_type
  ec2_ami_image_id            = var.ec2_ami_image_id
  launch_template_name        = var.launch_template_name
  generate_new_ssh_key        = var.generate_new_ssh_key
  existing_security_group_ids = var.existing_security_group_ids
  launch_template_description = var.launch_template_description
}
