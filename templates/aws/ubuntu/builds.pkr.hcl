# a build block invokes sources and runs provisioning steps on them.
build {
  name = "AeroSpike packer build"
  sources = [
      "source.amazon-ebs.focal-arm64",
  ]
  
  provisioner "shell" {
    script = "provisioners/aerospike-ubuntu-install.sh"
  }
}