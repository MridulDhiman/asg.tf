
variable "instance_type" {
    type = string
    description = "EC2 instance type"
}

variable "region" {
    type = string
    description = "AWS Region"
}

variable "ami_id" {
  type = string
  description = "Ubuntu AMI ID"
}

variable "vpc_cidr_block" {
  type = string
  description = "CIDR block for a particular VPC"
}