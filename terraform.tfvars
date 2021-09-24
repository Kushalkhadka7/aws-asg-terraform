vpc_cidr            = "192.168.0.0/16"
vpc_name            = "test_vpc"
private_subnet_cidr = "192.168.1.0/24"
public_subnet_cidr  = "192.168.2.0/24"
private_subnet_name = "Private Subnet"
public_subnet_name  = "Public Subnet"
private_route_cidr  = "192.168.0.0/16"
public_route_cidr   = "0.0.0.0/0"

# Auto scaling group
admin_asg_name            = "admin_asg"
min_size                  = 1
health_check_type         = "ELB"
health_check_grace_period = 300
default_cooldown_period   = 300
propagate_at_launch       = true
create_before_destroy     = true

# launch configurations
ec2_instance_type      = "t2.micro"
enable_monitoring      = true
ebs_optimized          = true
ebs_device_name        = "/dev/xvd"
ebs_volume_type        = "gp2"
ebs_volume_size        = "50"
delete_on_termination  = true
root_block_device_size = "50"
root_block_device_type = "gp2"


# Scale down policy.
scale_down_policy_name        = "scale_down_policy"
scale_down_scaling_adjustment = 1
scale_down_adjustemnt_type    = "ChangeInCapacity"
scale_down_cool_down          = 300
scale_down_policy_type        = "SimpleScaling"

# Scale up policy.
scale_up_policy_name        = "scale_up_policy"
scale_up_scaling_adjustment = 3
scale_up_adjustemnt_type    = "ChangeInCapacity"
scale_up_cool_down          = 300
scale_up_policy_type        = "SimpleScaling"


# rds
name              = "admin_db"
engine            = "mysql"
storage_size      = 20
storage_max       = 40
apply_immediately = true
db_username       = "my_db"
dn_password       = "password123"
engine_version    = "5.7"

# dynamo db
table_name     = "Users"
billing_mode   = "PROVISIONED"
read_capacity  = 2
write_capacity = 2
hash_key       = "name"
range_key      = "id"
stream_enabled = false
ttl_enabled    = false


# ALB
internal                    = false
load_balancer_type          = "application"
cross_zone_load_balancing   = true
idle_timeout                = 400
connection_draining         = true
connection_draining_timeout = 400
enable_http2                = false
enable_access_logs          = true
alb_logs_bucket_name        = "load_balancer"
alb_logs_bucket_prefix      = "load_balancer/"
alb_env                     = "dev"

# s3 Bucket
bucket_name        = "kushal-bucket-example1-bucket"
bucket_acl         = "public-read"
env                = "DEV"
enabled_versioning = true
