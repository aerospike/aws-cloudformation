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

2. Choose the Aerospike version you'd like to deploy.

3. Select if you'd like to publish base statistics to Cloudwatch.
  * Statistics are: Cluster Integrity, Free Memory, Free Disk and Number of Objects

4. Enter the size of an EBS volume you'd like to use. EBS volumes are always type gp2 and attached under /dev/sdg. Enter 0 to not use EBS volumes. An ephemeral volume is always available (if the instance type has them) under /dev/sdf

5. Choose an instance type from the ones available at
http://aws.amazon.com/ec2/instance-types/  
For more info on which instance to use, refer to Aerospike [AWS Capacity Planning](http://www.aerospike.com/docs/operations/aws/capacity_planning.html).

6. Choose a valid existing keypair. If you don't have a keypair in AWS already, [create one first](http://docs.aws.amazon.com/gettingstarted/latest/wah/getting-started-create-key-pair.html) 

7. *(Optional, but suggested)* Enter the URL where CloudFormation can download your customized namespace settings. This will be appended to the end of the aerospike.conf file as-is. 
  * The simplest method is to upload a file to S3, then making the file public. The direct link is available via the properties tab of the S3 object. 
  * Your custom namespace settings should take advantage of the ephemeral storage at /dev/sdf and your provisioned EBS volume at /dev/sdg.
  * Custom namespace file is everything under the namespace section of aerospike.conf file, including the namespace { } declaration.

8. Enter number of instances as required.

9. Enter the CIDR block from which you permit SSH access. You can use many online sites like [whatismyip](http://whatismyip.org/) to find out your IP. For single IP addresses appending /32 is required. Only 1 entry is permitted.

10. Choose if you'd like dedicated tenancy. There will be additional costs with this option.

11. Click Next

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

## System Access

SSH access is enabled on the instances under the **ec2-user** user using the key-pair you've selected during stack creation.  You are prompted to enter the IP (in CIDR format) from where you permit SSH access also during stack creation. 

## Cost
* EC2 instances
* GP2 EBS volume per instance 
* Cloudwatch metrics per instance
  * 4 metrics x 5 minute polling ~= 35000 API requests/mo = $0.35 + $2 for 4 metrics ~= $2.35
* SQS queue
  * 1 message on creation, 1 message per instance per scale-in. Fits into free tier. Would require a constant >2.5 scale-in events per second to exceed free tier.
* Dedicated tenancy. See [Dedicated instance pricing](https://aws.amazon.com/ec2/purchasing-options/dedicated-instances/) on AWS.


## Architecture
Cloudformation will create all the VPCs, Sunbnets, Security Groups, Autoscaling, etc... as separate entities just for the Aerospike cluster.

Upon instance startup, instances will run a userdata script that will query AWS for instances based on the unique StackID tag CloudFormation generates. This functionality requires the ec2-describe instance policy and utilizes IAM roles for this.

This script will then parse out the private IP addresses and modify the clustering section of aerospike configs with said IPs.

This cluster is resiliant to any node being added/dropped. Additional nodes added with autoscaling will be able to automatically join the cluster. **Nodes leaving the cluster must be triggered by autoscaling to keep guarantee data consistency**. On scale-in, an SQS message will be sent with information on which node is being terminated. The each node polls SQS for its own message. Once the node finds an SQS message for itself, it first checks for data migrations. If no migrations are occuring, it will stop ASD and continues the autoscaling termination process. If there are data migrations occuring, it will interrupt the scale-in, leaving the instance running and cluster untouched,  and wait for the next poll. **Only 1 node may scale-in at a time to ensure no data loss**

By default ping, Aerospike port 3000 and AMC port 8081 are open globally (0.0.0.0/0). You may want to lock this down to just your own IP range.
