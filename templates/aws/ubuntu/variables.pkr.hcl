
# Required variable, tbd
variable "region" {
  description = "Region where EC2 instance will launch to create AMI, example us-west-1."
  default     = "us-east-1"
  type        = string
}

# Required variable, tbd
variable "instance_type_arm64" {
  description = "The EC2 instance type to use while building the AMI, such as t2.large."
  default     = "t2.large"
  type        = string
}


variable "username" {
  type    = string
  default = "ubuntu"
  description = "vm username"
}

variable "password" {
  type    = string
  default = "password"
  description = "vm username"
}

variable "ami_name" {
  type    = string
  default = "aerospike-ubuntu-20.04"
}