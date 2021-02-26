locals {

  # This is appended to ami-name in console. format - 20210224002537
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")

  source_ami_owners = ["amazon"]
  # AMI name for OS architecture
  ami_names = {
    amzn2_amd64 = "amazonlinux2/arm64/${local.timestamp}"
  }
}