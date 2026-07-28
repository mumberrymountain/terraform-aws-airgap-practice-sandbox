variable "name_prefix" {
  description = "Prefix for resource names."
  type        = string
  default     = "airgap"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet that hosts the NAT instance."
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet that hosts the isolated EC2 instances."
  type        = string
  default     = "10.0.2.0/24"
}

variable "availability_zone" {
  description = "Single AZ for all subnets. Defaults to the first available AZ in the current region."
  type        = string
  default     = null
}

variable "key_name" {
  description = "Name of an existing EC2 key pair used for SSH to the NAT instance and private instances."
  type        = string
}

variable "ssh_allowed_cidr_blocks" {
  description = "CIDR blocks allowed to SSH into the NAT instance."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "private_instance_count" {
  description = "Number of private EC2 instances to create in the isolated subnet."
  type        = number
  default     = 3

  validation {
    condition     = var.private_instance_count >= 1
    error_message = "private_instance_count must be at least 1."
  }
}

variable "private_instance_ami" {
  description = "AMI ID for private EC2 instances. When null, the latest Ubuntu 24.04 LTS AMI is used."
  type        = string
  default     = null
}

variable "private_instance_type" {
  description = "Instance type for private EC2 instances."
  type        = string
  default     = "t3.medium"
}

variable "private_instance_ssh_user" {
  description = "SSH username for private EC2 instances."
  type        = string
  default     = "ubuntu"
}

variable "nat_instance_ami" {
  description = "AMI ID for the NAT instance. When null, the latest Amazon Linux 2023 AMI is used."
  type        = string
  default     = null
}

variable "nat_instance_type" {
  description = "Instance type for the NAT instance."
  type        = string
  default     = "t3.micro"
}

variable "nat_instance_ssh_user" {
  description = "SSH username for the NAT instance."
  type        = string
  default     = "ec2-user"
}

variable "tags" {
  description = "Tags applied to all supported resources."
  type        = map(string)
  default     = {}
}
