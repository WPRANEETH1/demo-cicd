variable "ec2_name" {
  type        = string
  description = "ec2_test"
}

variable "instance_type" {
  type = string
  description = "t2.medium"
}

variable "vpc_id" {
  type = string
  description = "VPC ID"
}

variable "ec2_subnets" {
  type        = list(string)
  description = "CIDRs for the public subnets"
}