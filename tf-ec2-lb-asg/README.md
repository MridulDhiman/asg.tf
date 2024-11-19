# Terraform config. for ALB with Auto Scaling Group of EC2 instances. 


### Terms
#### Security Group
 Providing inbound and outbound traffic rules (like a firewall) to particular resource.
#### Resource: 
Infrastructure that is being provisioned on the cloud.
#### Application Load Balancer (ALB): 
A type of load balancer provided by AWS, which distributes load and N/W traffic between diff. applications, working like a reverse proxy. AWS requires ALBs to be deployed across at least two Availability Zones for high availability.
#### Target Group: 
 Instance Group to which Load Balancer will forward request to, and will distribute the load to.
####  ALB Listener: 
It listens or monitors the entry of certain type of traffic e.g. HTTP, TCP, UDP etc. and then forward the request to Target Group.
#### Launch Template:
 Common EC2 template for the target group.
##### Auto Scaling Group: 
Group of EC2 instances with Launch Template, Target Group and Scaling policies configuration for a particular subnet of IP addresses. Here, we add Auto Scaling Group as a desired Target Group for ALB.
#### Scale-Up and Scale-Down Policies: 
 These policies need to be configured in the auto scaling group for handling auto scaling whenever specified metric (e.g. CPUUtilization) surpasses certain threshold.
#### CloudWatch Metric Alarms: 
Used to observe the metrics and start an alarm, and perform certain action(here, scale up or scale down) whenever threshold condition reached.
#### Health Checks:
 AWS can do health checks by automatic hitting certain endpoint (e.g. `/health`), configured in the target group.

---

> ALB and ASG must be available inside same VPC (virtual private cloud), while ASG will be configured to be in subnet of IP addresses within the VPC. Only the IP of ALB will be publicized and client will consider that as origin server (thus, a reverse proxy).

