# Aws-interview-questions

1. How is ec2 billing followed?
On-Demand Instances let you pay for compute capacity by the hour or second (minimum of 60 seconds) with no long-term commitments.

2. what is root volume in ec2?

Root volume is where boot files of OS and other important configuration files present
Root vol is automatically mounted on ec2


3. Is it possible to expand/increase root volume? and how?

Yes, possible. 

https://docs.aws.amazon.com/ebs/latest/userguide/requesting-ebs-volume-modifications.html

4. Is it possible to expand/increase additional EBS volume?

Yes possible.

https://docs.aws.amazon.com/ebs/latest/userguide/recognize-expanded-volume-linux.html


5. Is it possible to shrink volume?

Direct shrinking is not possible. However, take snapshot and restore on a lesser EBS volume, attach the same to ec2

https://docs.aws.amazon.com/ebs/latest/userguide/ebs-modify-volume.html
https://repost.aws/questions/QUPe0ekJ79TpaI-TNGoPXIKQ/can-i-reduce-an-over-sized-ebs-volume

Your best option if you'd like to decrease the EBS volume size is to:

Create a snapshot of the current volume
Create a new volume and mount it to the existing instance
Copy the data from the existing volume to the new volume
Delete the old volume


6. What is Burstable instance type?

https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/burstable-credits-baseline-concepts.html
Traditional Amazon EC2 instance types provide fixed CPU resources, while burstable performance instances provide a baseline level of CPU utilization with the ability to burst CPU utilization above the baseline level. This ensures that you pay only for baseline CPU plus any additional burst CPU usage resulting in lower compute costs. The baseline utilization and ability to burst are governed by CPU credits. Burstable performance instances are the only instance types that use credits for CPU usage.

Each burstable performance instance continuously earns credits when it stays below the CPU baseline, and continuously spends credits when it bursts above the baseline. The amount of credits earned or spent depends on the CPU utilization of the instance:

If the CPU utilization is below baseline, then credits earned are greater than credits spent.

If the CPU utilization is equal to baseline, then credits earned are equal to credits spent.

If the CPU utilization is higher than baseline, then credits spent are higher than credits earned.


7. Is it possible to block a port in security group?

No, Only allowing a port is possible

8. What are the reasons when an EBS volume couldn't be attached to an instance ?

    If the vol is created in different zone/region than the EC2 machine
    If the vol is already allocated to some other ec2 instance

9. How to Migrate an instance from one region to another?

Take AMI, copy it to another region
Then launch instance from the AMI

10. AMI vs snapshot?

https://repost.aws/questions/QU0Wj95Y5hSEKoAvFeaDrsfg/ami-vs-ebs-snapshots

AMI (Amazon Machine Image): An AMI is a template that contains the necessary information to launch an EC2 instance, including the operating system, application server, and applications. It essentially captures the entire state of a virtual server, including its configuration, and can be used to launch identical instances.

EBS Snapshot (Elastic Block Store Snapshot): An EBS snapshot is a point-in-time copy of an EBS volume. It captures all the data on the volume at the time the snapshot is taken. EBS snapshots are used for backup, replication, and disaster recovery purposes.

11. How to find out instance region without console?

Using metadata service Via SSH

IMDS - Instance Metadata Service
https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/configuring-instance-metadata-service.html

12. Is it possible to access ssh without key?

yes possible.
Using Session manager or EC2 instance connect

13. What is golden AMI?

AMI with preinstalled software packages

13. Will public ip change when stop start the instance ?

Yes

14. Public subnet vs private subnet 

Depends on oute table which is associated to the subnet contains Internet gateway entry. If yes, public subnet. If no private subnet

15. What is Elastic IP?

Static public IP

16. NAT gateway vs IGW?

NAT allows only outgoing connections
IGW allows incoming and outgoing connections

17. Security group vs NACL?

Security groups act as a stateful firewall for individual instances or resources, while NACLs act as a stateless firewall for subnets

18. VPC peering vs Transit gateway?

VPC Peering provides direct, one-to-one connections between VPCs, while Transit Gateway acts as a central hub for connecting multiple VPCs, VPNs simplifying management and scaling. 

19. Ebs backed instance vs instance store backed instance 

EBS-backed instances use Elastic Block Storage volumes for persistent storage, while instance store-backed instances rely on temporary storage directly attached to the host server.
https://repost.aws/knowledge-center/instance-store-vs-ebs

20. What are the Private ip ranges?
10.0.0.0 to 10.255.255.255
172.16.0.0 to 172.31.255.255
192.168.0.0 to 192.168.255.255

21. Public hosted zone vs Private hosted zone 
Public hosted zones are used to route traffic on the public internet, while private hosted zones route traffic within a specific Amazon Virtual Private Cloud (VPC)

22. EFS vs EBS

Single vs. Multi-Instance Access:
EBS is for single-instance storage, while EFS is designed for shared access by multiple instances. 
Performance:
EBS generally offers lower latency and higher performance for demanding applications, while EFS is optimized for scalability and availability. 
Use Cases:
EBS is often used for databases and system drives, while EFS is ideal for shared file storage across multiple instances. 
Cost:
EBS is generally cheaper for single-instance storage, while EFS can be more cost-effective for shared storage needs. 

https://repost.aws/questions/QU0AftMN0NRpe0vFPkYx__SQ/amazon-efs-vs-amazon-ebs


23. dedicated host vs dedicated instance 
Dedicated Host
A Dedicated Host gives you an entire physical server to yourself. You have visibility into and control over the underlying hardware — sockets, cores, and host ID. It’s ideal for scenarios where you need to bring your own software licenses (like Windows or SQL Server) and meet strict compliance or regulatory requirements.

Dedicated Instance
This also runs on hardware that's dedicated to you, but unlike a Dedicated Host, you don't get detailed control over the physical server. It provides instance-level isolation but doesn’t support advanced licensing or compliance features. It's simpler but less customizable.


24. Spot instance vs reserve instance 
Spot Instance
Spot Instances let you use unused EC2 capacity at up to 90% discount. They're cost-effective but can be interrupted by AWS with just a 2-minute warning. Great for short-term, fault-tolerant jobs like batch processing, CI/CD, or data crunching.

Reserved Instance (RI)
Reserved Instances require you to commit to a specific instance type in a specific region for 1 or 3 years. In return, you get a significant discount (up to 75%) over on-demand pricing. They’re perfect for steady, long-running workloads like production servers

25. Horizontal scaling vs vertical scaling
Horizontal Scaling (Scale Out / Scale In)
This means adding or removing more machines (instances) to handle the load. For example, adding more EC2 instances behind a load balancer to serve more users. It improves fault tolerance and is ideal for cloud-native or microservices architectures.

Vertical Scaling (Scale Up / Scale Down)
This means increasing or decreasing the size of a single server — like upgrading from t3.medium to m5.2xlarge to get more CPU and RAM. It’s easier to implement but has hardware limits.

26. IAM user vs IAM group 
IAM User
An IAM User represents a person or an application. It has long-term credentials like a username, password, and access keys. Permissions are attached to the user directly or via a group.

IAM Group
A group is a collection of IAM users. Instead of assigning permissions to each user one by one, you assign policies to the group — and all users in the group automatically inherit those permissions.


27. IAM user vs IAM role
IAM User
Has long-term credentials and is meant for a specific person or application that interacts with AWS consistently.

IAM Role
Doesn’t have long-term credentials. It’s assumed temporarily by trusted users, services, or even AWS accounts. Roles are great for cross-account access, temporary access, or when EC2/ Lambda needs to perform actions on AWS.

28. IAM policy vs inline policy 
IAM Policy (Managed Policy)
A standalone permission document that can be attached to multiple IAM identities (users, groups, roles). There are two types:

AWS managed (predefined by AWS)

Customer managed (you create and manage it)

Inline Policy
A policy embedded directly into a single user, group, or role. It’s tightly coupled and cannot be reused elsewhere.

29. IAM policy vs bucket policy
IAM Policy
Controls what an IAM identity (user/role/group) can do in AWS. You attach it to identities to give them permissions to act on resources.

Bucket Policy
A resource-based policy that is attached to an S3 bucket, not an identity. It controls who (including anonymous users, external accounts) can access the bucket and its contents.



30. Structure of policy
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",                         // Allow or Deny
      "Action": "s3:PutObject",                  // AWS service actions
      "Resource": "arn:aws:s3:::my-bucket/*"     // Resource ARN
    }
  ]
}
Version: Always use "2012-10-17" (latest version).

Statement: The actual rule(s) in the policy.

Effect: Allow or Deny.

Action: What action(s) are allowed or denied (e.g., ec2:StartInstances).

Resource: Which resource(s) the actions apply to (e.g., an S3 bucket ARN).

(Optional) Condition: Add conditions like IP address, MFA, time of day, etc.


31. What is AutoScaling Group

An Auto Scaling Group in AWS is a service that automatically manages a group of EC2 instances based on demand. It helps maintain high availability, performance, and cost efficiency by automatically launching or terminating EC2 instances according to rules you define.

32. Scaling policies in ASG - static and dynamic scaling, scheduled, predictive

1. Target Tracking Scaling
Simplest and most commonly used policy
You define a target value (e.g., average CPU = 60%), and ASG automatically adjusts to keep that target.
It works like a thermostat: adds/removes instances to maintain the target.

Example:
Maintain average CPU utilization at 60%.
If average CPU goes above 60%, ASG adds instances.
If it goes below 60%, ASG removes instances.

2. Step Scaling
Allows you to define different scaling actions for different thresholds.
You set CloudWatch alarms and configure "steps" (scaling adjustments) based on how far the metric deviates.

Example:

If CPU > 60% → add 1 instance

If CPU > 80% → add 2 instances

If CPU < 30% → remove 1 instance

Useful when you need fine-grained control over scaling based on demand levels.

3. Simple Scaling (Legacy option)
Triggered when a single CloudWatch alarm is breached.
Performs one scaling action (like add/remove 1 instance) and waits a cooldown period before evaluating again.
Less flexible than step or target tracking, mostly used in legacy setups.

4. Scheduled Scaling
Launches or terminates instances at specific times.
Great for predictable workloads like office hours, nightly batch jobs, etc.

Example:

Increase to 10 instances at 8 AM (weekday traffic)
Reduce to 2 instances at 10 PM (off-hours)

33. Instance down notifications
Using SNS

34. ALB vs NLB
✅ Application Load Balancer (ALB)
Works at Layer 7 (Application Layer) of the OSI model.

Understands HTTP and HTTPS protocols, so it can inspect and make decisions based on:

Hostnames

Paths (/api/, /login, etc.)

Headers, query strings, cookies, etc.

Best for web applications that need advanced routing and content-based rules.

Example Use Cases:

Routing /admin traffic to one service and /user to another.
Forwarding requests to different microservices based on hostname or path.
Terminating SSL (HTTPS) and redirecting HTTP to HTTPS.

✅ Network Load Balancer (NLB)
Works at Layer 4 (Transport Layer).

Supports TCP, UDP, and TLS traffic.

Extremely fast and efficient, built for high-performance, low-latency use cases.

Does not inspect content, just forwards based on IP and port.

Example Use Cases:

Load balancing for database traffic (e.g., MySQL over TCP)
IoT or gaming apps with UDP/TCP
When you need to preserve the client's IP address

35. Sticky sessions 

Sticky sessions ensure that a user’s requests are always routed to the same backend server for the duration of their session.

This is important when:

The server stores session-specific data in memory (like login state, shopping cart, etc.).
You don’t use a centralized session store (like Redis or DynamoDB).

Sticky sessions bind the user to one server, ensuring a consistent experience.


36. Route 53 records
 A Record (Address Record)
Maps a domain name to an IPv4 address.

🔹 AAAA Record
Same as A record, but maps to an IPv6 address.

🔹 CNAME Record (Canonical Name)
Points one domain name to another domain name.

Example:
www.example.com → example.com

⚠️ Can’t create a CNAME at the root domain (e.g., example.com), only for subdomains like www.example.com.

🔹 Alias Record (Route 53 specific)
Similar to CNAME but can be used at the root domain level.

Points to AWS resources like:

Elastic Load Balancer (ALB/NLB), CloudFront distributions, S3 static website hosting

Example:
example.com → my-loadbalancer-123.elb.amazonaws.com

✅ Preferable over CNAME for AWS services since it’s free and integrates well.

🔹 MX Record (Mail Exchange)
Used to route email traffic.

Points to mail servers that accept emails for your domain.

🔹 TXT Record
Stores text information in DNS.

Common uses:

Domain verification (for services like Google, AWS SES)
SPF/DKIM/DMARC email authentication

🔹 NS Record (Name Server)
Indicates which name servers are authoritative for the domain.
Automatically created when you create a hosted zone.

🔹 SRV Record
Used to define services (like SIP or LDAP).
Format includes protocol, port, priority, weight, etc.

🔹 PTR Record
Reverse DNS lookup — maps IP addresses to domain names.


37. Routing policies
Route 53 also supports routing policies to control how traffic is directed:

Simple routing – Basic DNS resolution (e.g., A record)

Weighted routing – Distribute traffic by percentage

Latency-based routing – Send users to the region with the lowest latency

Geolocation routing – Route traffic based on the user's country or region

Failover routing – Automatic health check + failover setup

Multivalue answer routing – Acts like round robin + health checks


38. S3 storage classes

S3 Standard
S3 Intelligent-Tiering
S3 Standard-IA (Infrequent Access)
S3 One Zone-IA
S3 Glacier Instant Retrieval
S3 Glacier Flexible Retrieval (formerly Glacier)
S3 Glacier Deep Archive

39. EC2 to S3 access
Using IAM Role

40. VPC endpoints 
Connect S3 and Dynamoc DB within VPC