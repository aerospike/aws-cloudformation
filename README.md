aws-cloudformation
==================

AWS CloudFormation scripts related to Aerospike

Download a copy of this repo using either the Download link or use git clone.


## Usage
Go to AWS Cloud formation console at https://console.aws.amazon.com/cloudformation/home

Change the region as per your requirement.

**Uploading the template**

1. Choose "Create New Stack".

2. Upload the aerospike-cf.json found in this repo.

3. Click Next

**Template Parameters**

1. Give a name to your stack

2. Choose the Aerospike Version you'd like to deploy.

3. Choose an instance type from the ones available at
http://aws.amazon.com/ec2/instance-types/  
For more info on which instance to use, refer to Aerospike [AWS Capacity Planning](http://www.aerospike.com/docs/operations/aws/capacity_planning.html).

4. Choose a valid existing keypair. If you don't have a keypair in AWS already, [create one first](http://docs.aws.amazon.com/gettingstarted/latest/wah/getting-started-create-key-pair.html) If you do not provide a keypair file name, you will not be able to ssh into the instances.

5. *(Optional)* Enter the URL where CloudFormation can download your customized namespace settings. This will be appended to the end of the aerospike.conf file as-is.
  * The simplest method is to upload a file to S3, then making the file public. The direct link is available via the properties tab of the S3 object. 

6. Enter number of instances as required.

7. Click Next

**Options** (Optional)
* Enter additional tags as desired.

**Advanced** (Optional)
* Enter advanced configurations as desired.
* Click Next

**Review**
* Check "I acknowledge that this template might cause AWS CloudFormation to create IAM resources." This is required for cluster discovery. See Architecture for details.
* Review and click Create.

Go to your EC2 console and login to the instances using the IPs listed against the instances.

Fire off some load using the [java benchmark client](http://www.aerospike.com/docs/client/java/benchmarks.html) included in the instances and watch the load with [AMC](http://www.aerospike.com/docs/amc/) 

## SSH Access

SSH access is not required to use Aerospike. With this in mind, and in accord with best seurity practices, port 22 is not open in the security group definition.

You may still open port 22 yourself. Once the port is opened, you may SSH in as the **ec2-user** using the keypair configured through this cloudformation script.



***Architecture***
Cloudformation will create all the VPCs, Sunbnets, Security Groups, Autoscaling, etc... as separate entities just for the Aerospike cluster.

Upon instance startup, instances will run a userdata script that will query AWS for instances based on the unique StackID tag CloudFormation generates. This functionality requires the ec2-describe instance policy and utilizes IAM roles for this.

This script will then parse out the private IP addresses and modify the clustering section of aerospike configs with said IPs.

This cluster is resiliant to any node being added/dropped. Additional nodes added with autoscaling will be able to automatically join the cluster.

By default, Ping, SSH, Aerospike ports 3000 and AMC port 8081 are open globally (0.0.0.0/0). You may want to lock this down to just your own IP range.
