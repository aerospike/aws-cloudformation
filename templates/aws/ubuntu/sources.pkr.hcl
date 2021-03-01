# source blocks configures builder plugins; it is used inside
# build blocks to create resources. A build block runs provisioners and
# post-processors on an instance created by the source.
source "amazon-ebs" "focal-arm64" {

  source_ami_filter {
    filters = {
      name                = "ubuntu/images/hvm-ssd/*ubuntu-focal-20.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = local.source_ami_owners
  }

  ami_name                    = "${var.ami_name}-${local.timestamp}"
  ami_description             = "Aerospike 5.5.0.3 AMI"
  instance_type               = var.instance_type_amd64
  region                      = var.region
  ssh_username                = var.username
  pause_before_connecting     = "30s"
  associate_public_ip_address = true
  communicator                = "ssh"

  tags = {
    Name              = local.ami_names.focal_amd64
    OS_Version        = "20.04"
    OS_Arch           = "x86_64"
    OS_Name           = "Ubuntu"
    Runner            = "EC2"
    Aerospike_Version = "5.5.0.3"
  }
}