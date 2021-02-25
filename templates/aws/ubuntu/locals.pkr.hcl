locals { 

    # This is appended to ami-name in console. format - 20210224002537
    timestamp = regex_replace(timestamp(), "[- TZ:]", "") 

    source_ami_owners = ["099720109477"]
    # AMI name for OS architecture
    ami_names = {
        focal_arm64  = "ubuntu/20.04/arm64/${local.timestamp}"
    }
}