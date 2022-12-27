locals {
  use_existing_key_pair = var.ssh_key_pair_name != "" ? 1 : 0
  generate_ssh_key_pair = var.ssh_key_pair_name == "" ? 1 : 0
  ssh_key_name          = local.generate_ssh_key_pair > 0 ? module.key_pair_test.generated_ssh_key_name : join("", data.aws_key_pair.this.*.key_name)

  should_create_default_sg = length(var.existing_security_group_ids) > 0 ? 0 : 1

  existing_iam_ec2_instance_profiles = length(var.existing_iam_instance_profiles) > 0 ? var.existing_iam_instance_profiles : []
  network_interfaces_info            = var.network_interfaces_description != "" ? var.network_interfaces_description : "default-network-interfaces"
}

# Generate SSH key pair.
module "key_pair_test" {
  source = "../ssh-key"

  key_name             = "new_test_key"
  generate_new_ssh_key = local.generate_ssh_key_pair
}

# Get SSH key pair if exists.
# Use the existing key pair instead of creating new one.
data "aws_key_pair" "this" {
  count = local.use_existing_key_pair

  key_name           = var.ssh_key_pair_name
  include_public_key = true
}

# Create default security group if not given any.
resource "aws_security_group" "default" {
  count = local.should_create_default_sg

  name        = "default-ec2-sg"
  description = "Security Group for EKS worker nodes"
  vpc_id      = var.vpc_id
}

# Default security group egerss rule.
resource "aws_security_group_rule" "egress" {
  count             = local.should_create_default_sg
  description       = "Allow all egress traffic"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = join("", aws_security_group.default.*.id)
  type              = "egress"
}

# Default security group ingerss rule.
resource "aws_security_group_rule" "ingress_self" {
  count             = local.should_create_default_sg
  description       = "Allow communication from anywhere"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  security_group_id = join("", aws_security_group.default.*.id)
  cidr_blocks       = ["0.0.0.0/0"]
  type              = "ingress"
}

# Creates launch template for the EC2 instances.
resource "aws_launch_template" "this" {
  count = var.launch_template_id != "" ? 0 : 1

  image_id    = var.ec2_ami_image_id
  name        = var.name_space != "" ? null : var.launch_template_name
  name_prefix = var.name_space != "" ? "${var.name_space}-${var.launch_template_name}" : null
  description = var.launch_template_description

  disable_api_termination              = var.disable_api_termination
  ebs_optimized                        = var.ebs_optimized
  instance_initiated_shutdown_behavior = var.instance_initiated_shutdown_behavior
  instance_type                        = var.instance_type
  key_name                             = local.ssh_key_name
  user_data                            = var.user_data_base64 != "" ? var.user_data_base64 : filebase64("${path.module}/userdata.sh")

  # This is similar to attaching role to ec2 instances.
  # Instead of it we create an `iam_instance_profile` attach the role to it
  # and attach `iam_instance_profile` to the ec2 instances.
  # This enables us to attache more than 1 IAM instakce profile for undrlying EC2 instances.
  dynamic "iam_instance_profile" {
    for_each = local.existing_iam_ec2_instance_profiles

    content {
      name = iam_instance_profile.value
    }
  }

  # If this is enabled, ec2 instances will have detailed monitoring enabled.
  # Enabling this might cost a little bit more.
  monitoring {
    enabled = var.enable_monitoring
  }

  network_interfaces {
    description                 = local.network_interfaces_info
    associate_public_ip_address = var.associate_public_ip_address
    security_groups             = local.should_create_default_sg > 0 ? aws_security_group.default.*.id : var.existing_security_group_ids
  }

  # [NOTE]: This needs to be updated.
  # dynamic "placement" {
  #   for_each = var.placement != null ? [var.placement] : []

  #   content {
  #     host_id           = lookup(placement.value, "host_id", null)
  #     tenancy           = lookup(placement.value, "tenancy", null)
  #     affinity          = lookup(placement.value, "affinity", null)
  #     group_name        = lookup(placement.value, "group_name", null)
  #     availability_zone = lookup(placement.value, "availability_zone", null)
  #   }
  # }

  # Tags for the EC2 instances that will be created using this launch template.
  tag_specifications {
    resource_type = "instance"
    tags = merge({
      Name = "EC2 instance"
    }, var.tags, var.additional_launch_template_tags)
  }

  lifecycle {
    create_before_destroy = true
  }


  # From the above configurations EC2 instances will be create.
  # If we want to attach block storage devices to the created instances.
  dynamic "block_device_mappings" {
    for_each = var.block_device_mappings
    content {
      device_name  = lookup(block_device_mappings.value, "device_name", null)
      no_device    = lookup(block_device_mappings.value, "no_device", null)
      virtual_name = lookup(block_device_mappings.value, "virtual_name", null)

      dynamic "ebs" {
        for_each = flatten([lookup(block_device_mappings.value, "ebs", [])])
        content {
          delete_on_termination = lookup(ebs.value, "delete_on_termination", null)
          encrypted             = lookup(ebs.value, "encrypted", null)
          iops                  = lookup(ebs.value, "iops", null)
          kms_key_id            = lookup(ebs.value, "kms_key_id", null)
          snapshot_id           = lookup(ebs.value, "snapshot_id", null)
          volume_size           = lookup(ebs.value, "volume_size", null)
          volume_type           = lookup(ebs.value, "volume_type", null)
        }
      }
    }
  }

  # Market purchasing option for instances.
  # If these requirements meets then the spot instance will be used.
  dynamic "instance_market_options" {
    for_each = var.instance_market_options != null ? [var.instance_market_options] : []

    content {
      market_type = lookup(instance_market_options.value, "market_type", null)

      dynamic "spot_options" {
        for_each = flatten([lookup(instance_market_options.value, "spot_options", [])])

        content {
          block_duration_minutes         = lookup(spot_options.value, "block_duration_minutes", null)
          instance_interruption_behavior = lookup(spot_options.value, "instance_interruption_behavior", null)
          max_price                      = lookup(spot_options.value, "max_price", null)
          spot_instance_type             = lookup(spot_options.value, "spot_instance_type", null)
          valid_until                    = lookup(spot_options.value, "valid_until", null)
        }
      }
    }
  }
}
