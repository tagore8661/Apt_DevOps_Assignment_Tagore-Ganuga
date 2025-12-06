variable "region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "List of public subnet CIDRs (2 entries)"
  type        = list(string)
  default     = ["10.0.0.0/24", "10.0.1.0/24"]
}

variable "private_subnets" {
  description = "List of private subnet CIDRs (2 entries)"
  type        = list(string)
  default     = ["10.0.10.0/24", "10.0.11.0/24"]
}

variable "instance_type" {
  description = "EC2 instance type for launch template"
  type        = string
  default     = "t3.micro"
}

variable "desired_capacity" {
  description = "ASG desired capacity"
  type        = number
  default     = 1
}

variable "min_size" {
  description = "ASG minimum size"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "ASG maximum size"
  type        = number
  default     = 2
}

variable "tags" {
  description = "Map of tags to apply to resources"
  type        = map(string)
  default     = {}
}
