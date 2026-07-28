variable "aws_region" {
  description = "AWS region for the example deployment."
  type        = string
  default     = "ap-northeast-2"
}

variable "name_prefix" {
  description = "Prefix for resource names."
  type        = string
  default     = "airgap-practice"
}

variable "key_name" {
  description = "Name of an existing EC2 key pair in the target region."
  type        = string
}

variable "ssh_allowed_cidr_blocks" {
  description = "CIDR blocks allowed to SSH into the NAT instance."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "private_instance_count" {
  description = "Number of private EC2 instances."
  type        = number
  default     = 3
}

variable "private_instance_ami" {
  description = "Optional AMI override for private instances."
  type        = string
  default     = null
}

variable "private_instance_type" {
  description = "Instance type for private EC2 instances."
  type        = string
  default     = "t3.medium"
}

variable "nat_instance_ami" {
  description = "Optional AMI override for the NAT instance."
  type        = string
  default     = null
}

variable "nat_instance_type" {
  description = "Instance type for the NAT instance."
  type        = string
  default     = "t3.micro"
}
