variable "name" {
  default     = "stage"
  type        = string
  description = "Name of the VPC"
}

variable "vpc_cidr" {
  default = "10.1.0.0/16"

}
variable "pub_cidr" {
  type    = list(any)
  default = ["10.1.0.0/24", "10.1.1.0/24", "10.1.2.0/24"]

}

variable "private_cidr" {
  type    = list(any)
  default = ["10.1.3.0/24", "10.1.4.0/24", "10.1.5.0/24"]

}

variable "data_cidr" {
  type    = list(any)
  default = ["10.1.6.0/24", "10.1.7.0/24", "10.1.8.0/24"]

}


variable "project" {
  type        = string
  default     = "kfc"
  description = "Name of project this VPC is meant to house"
}

variable "environment" {
  type        = string
  default     = "stage"
  description = "Name of environment this VPC is targeting"
}

variable "region" {
  default     = "ap-southeast-1"
  type        = string
  description = "Region of the VPC"
}

# variable "key_name" {
#   type        = string
#   description = "EC2 Key pair name for the bastion"
# }

# variable "cidr_block" {
#   default     = "10.0.0.0/16"
#   type        = string
#   description = "CIDR block for the VPC"
# }

# variable "public_subnet_cidr_blocks" {
#   default     = ["10.0.0.0/24", "10.0.2.0/24"]
#   type        = list
#   description = "List of public subnet CIDR blocks"
# }

# variable "private_subnet_cidr_blocks" {
#   default     = ["10.0.1.0/24", "10.0.3.0/24"]
#   type        = list
#   description = "List of private subnet CIDR blocks"
# }

# variable "availability_zones" {
#   default     = ["us-east-1a", "us-east-1b"]
#   type        = list
#   description = "List of availability zones"
# }

# variable "bastion_ami" {
#   type        = string
#   description = "Bastion Amazon Machine Image (AMI) ID"
# }

# variable "bastion_ebs_optimized" {
#   default     = false
#   type        = bool
#   description = "If true, the bastion instance will be EBS-optimized"
# }

# variable "bastion_instance_type" {
#   default     = "t3.nano"
#   type        = string
#   description = "Instance type for bastion instance"
# }

variable "tags" {
  default     = {}
  type        = map(string)
  description = "Extra tags to attach to the VPC resources"
}

variable "db_password" {
  description = "RDS root user password"
  type        = string
  sensitive   = true
}