Aerospike AMI using Packer
==================

 This repo contains instructions to build Enterprise Aerospike AMI using hashicorp [Packer]
 
 Templates will install Aerospike 5.5.0.3.


 Currently following distrubutions are supported : 
 * Ubuntu 20.04 ("Focal") LTS
 * Amazon Linux 2


## Prerequisites

* AWS CLI, installation instructions can be found [here][aws-install]
* Packer >= 1.7.0, packer installation instructions can be found [here][Packer-install]
* AWS account with access to create, update ec2 instance, ebs. This can be restricted based on IAM task or Instance Role as per [Packer][Packer-Role] docs
* User have knowledge of region where they with to build ami, otherwise default region is selected (us-west-1)



## Usage
Export AWS variables
```bash
$ export AWS_ACCESS_KEY_ID=<AWS_ACCESS_KEY_ID>
$ export AWS_SECRET_ACCESS_KEY=<AWS_SECRET_ACCESS_KEY>
```

Following will build ami for the template and install aerospike on the system.
```bash
$ packer build -var 'region=<AWS_REGION>' templates/aws/[name]
```
#### script options 
* `region` - [optional] The region where build will be performed. Default `us-east-1`. It is recommended to provide this value
* `instance_type_amd64` - [optional] The instance type for the instance. Default `t2.large`.

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


[Packer]: https://www.packer.io/docs
[Packer-Role]: https://www.packer.io/docs/builders/amazon#iam-task-or-instance-role
[Packer-install]: https://www.packer.io/docs/install
[aws-install]: https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html