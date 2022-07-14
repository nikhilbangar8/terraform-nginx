variable "aws_region" {
  description = "The AWS region where nginx server is going to be installed"
}

variable "vpc_cidr" {
  description = "IPV4 CIDR for the VPC"
}

variable "primary_sub_cidr" {
  description = "IPV4 CIDR for the Primary Subnet"
}

variable "secondary_sub_cidr" {
  description = "IPV4 CIDR for the Secondary Subnet"
}