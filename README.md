Aerospike AMI using Packer
==================

 This repo contains instructions to bake Aerospike ami using hashicorp packer [https://www.packer.io/docs]


## Prerequisites

* Packer is installed in the system
* AWS account with access to create, update ec2 instance, ebs. This can be restricted based on IAM task or Instance Role as per https://www.packer.io/docs/builders/amazon#iam-task-or-instance-role

* This assumes that user is aware of region where instance will launch to create ami


## Usage
```bash
$ export AWS_ACCESS_KEY_ID=<AWS_ACCESS_KEY_ID>
$ export AWS_SECRET_ACCESS_KEY=<AWS_SECRET_ACCESS_KEY>
$ packer build -var 'region=[region]' templates/aws/[name]
```


## Troubleshooting
use  `packer validate` command to validate template and `packer fmt` to format the template.
```bash
$ packer validate templates/aws/ubuntu
```

## Future Works
* Integrate with CI/CD pipeline
* Scanninng AMI for security vlunerability
* Notification for failures when AMI build fails
* Automated test for newly built AMI
* Decommission old AMI after retention period (*)