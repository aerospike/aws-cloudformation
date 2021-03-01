# a build block invokes sources and runs provisioning steps on them.
build {
  name = "Aerospike amzn2 packer build"
  sources = [
    "source.amazon-ebs.amzn2-amd64",
  ]

  provisioner "shell" {
    script = "provisioners/aerospike_amazonlinux_install.sh"
  }
}