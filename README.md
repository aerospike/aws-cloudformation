aws-cloudformation
==================

AWS CloudFormation scripts related to Aerospike

Download a copy of this repo using either the Download link or use git clone.

Go to AWS Cloud formation console at https://console.aws.amazon.com/cloudformation/home

Change the region as per your requirement.

Choose "Create New Stack".

Give a name to your stack

Upload the aerospike-cf.json found in this repo.

Choose an instance type from the ones available at

http://aws.amazon.com/ec2/instance-types/

For more info on which instance to use, refer to Aerospike [AWS Capacity Planning](http://www.aerospike.com/docs/operations/aws/capacity_planning.html).

Choose a valid existing keypair. If you don't have a keeper in AWS already, [create one first](http://docs.aws.amazon.com/gettingstarted/latest/wah/getting-started-create-key-pair.html) If you do not provide a keypair file name, you will not be able to login to the instances.

Put number of instances as required.

Click Next

Put a tag key value pair as required.

Click Next

Review and click create.

Go to your EC2 console and login to the instances using the IPs listed against the instances.

Fire load using the [java benchmark client](http://www.aerospike.com/docs/client/java/benchmarks.html) included in the instances and watch the load with [AMC](http://www.aerospike.com/docs/amc/) 


***Architecture***
Cloudformation will create all the VPCs, Sunbnets, Security Groups, Autoscaling, etc... required.
Upon instance startup, instances will run a userdata script that will query AWS for instances based on the unique StackID tag CloudFormation generates.
This script will then parse out the private IP addresses and modify the clustering section of aerospike configs with said IPs.

This cluster is resiliant to any node being added/dropped.
