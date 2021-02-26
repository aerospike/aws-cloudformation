# source blocks configures builder plugins; it is used inside
# build blocks to create resources. A build block runs provisioners and
# post-processors on an instance created by the source.
source "amazon-ebs" "amzn2-amd64" {

  source_ami_filter {
    filters = {
      name                = "amzn2-ami-hvm*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = local.source_ami_owners
  }

  ami_name                    = "${var.ami_name}-${local.timestamp}"
  ami_description             = "Aerospike 5.5.0.3 AMI for Amazon linux 2"
  instance_type               = var.instance_type_amd64
  region                      = var.region
  ssh_username                = var.username
  pause_before_connecting     = "30s"
  associate_public_ip_address = true
  communicator                = "ssh"

  tags = {
    Name              = local.ami_names.amzn2_amd64
    OS_Version        = "2"
    OS_Arch           = "x86_64"
    OS_Name           = "Amazon linux"
    Runner            = "EC2"
    Aerospike_Version = "5.5.0.3"
  }
}