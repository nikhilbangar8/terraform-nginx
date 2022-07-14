variable "instance_type" {
  description = "Nginx Instance Type"
  default = "t3.medium"
}

variable "vpc_id" {
  description = "VPC ID"
}

variable "primary_subnet_id" {
  description = "primary_subnet_id"
}

variable "secondary_subnet_id" {
  description = "secondary_subnet_id"
}

variable "ssh_access_cidr" {
  description = "ssh_access_cidr to access into nginx-server"
}