# Ec2 instance configuration to be attached in the auto scaling group.
resource "aws_launch_configuration" "default" {
  image_id          = var.ec2_image_id
  instance_type     = var.ec2_instance_type
  security_groups   = var.ec2_security_groups
  enable_monitoring = var.enable_monitoring
  ebs_optimized     = var.ebs_optimized

  ebs_block_device {
    device_name           = var.ebs_device_name
    volume_type           = var.ebs_volume_type
    volume_size           = var.ebs_volume_size
    delete_on_termination = var.delete_on_termination
  }


  root_block_device {
    volume_size = var.root_block_device_size
    volume_type = var.root_block_device_type
  }
}
