#Network Module
aws_region          = "eu-west-1"
vpc_cidr            = "10.37.0.0/16"
primary_sub_cidr    = "10.37.0.0/24"
secondary_sub_cidr  = "10.37.1.0/24"

#Compute Module
instance_type = "t3.medium"
ssh_access_cidr = "0.0.0.0/0"