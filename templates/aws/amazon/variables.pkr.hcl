
# Required variable, tbd
variable "region" {
  description = "Region where AMI will be placed, example us-east-1."
  default     = "us-east-1"
  type        = string
}

# Required variable, tbd
variable "instance_type_amd64" {
  description = "The EC2 instance type to use while building the AMI, such as t2.large."
  default     = "t2.large"
  type        = string
}


variable "username" {
  type        = string
  default     = "ec2-user"
  description = "vm username"
}

variable "password" {
  type        = string
  default     = "password"
  description = "vm username"
}

variable "ami_name" {
  type    = string
  default = "aerospike-amazonlinux2"
}