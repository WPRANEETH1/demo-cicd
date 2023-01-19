variable "vpc_name" {
  default     = "aws-jenkins-ec2"
  type        = string
  description = "aws-jenkins-ec2"
}

variable "project" {
  default     = "aws-ecs"
  type        = string
  description = "aws-ecs"
}

variable "tags" {
  default     = {}
  type        = map(string)
  description = "Extra tags to attach to the VPC resources"
}

variable "environment" {
  default     = "test"
  type        = string
  description = "test environment"
}

variable "cidr_block" {
  default     = "10.15.0.0/16"
  type        = string
  description = "CIDR block for the VPC"
}

variable "public_subnet_cidr_blocks" {
  default     = ["10.15.0.0/18", "10.15.64.0/18"]
  type        = list(any)
  description = "List of public subnet CIDR blocks"
}

variable "private_subnet_cidr_blocks" {
  default     = ["10.15.128.0/18", "10.15.192.0/18"]
  type        = list(any)
  description = "List of private subnet CIDR blocks"
}

variable "availability_zones" {
  default     = ["us-east-1a", "us-east-1b"]
  type        = list(any)
  description = "List of availability zones"
}

variable "availability_zones_ref" {
  default     = ["a", "b"]
  type        = list(any)
  description = "List of availability zones reference"
}

variable "region" {
  default     = "us-east-1"
  type        = string
  description = "Region of the VPC"
}

variable "ecs_name" {
  default     = "ecs-fargate"
  type        = string
  description = "ecs-fargate"
}

variable "ecr_name" {
  default     = "demo-app"
  type        = string
  description = "ecr registry name"
}

variable "ecr_port" {
  default     = 80
  type        = number
  description = "ecr running port"
}
