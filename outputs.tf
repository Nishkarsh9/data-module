output "all_vpcs" {
  description = "List of all VPC IDs in the region"
  value       = data.aws_vpcs.all.ids
}

output "vpc_details" {
  description = "Detailed information about all VPCs"
  value       = { for k, v in data.aws_vpc.details : k => {
    id         = v.id
    cidr_block = v.cidr_block
    state      = v.state
  } }
}

output "all_subnets" {
  description = "List of all subnet IDs in the region"
  value       = data.aws_subnets.all.ids
}

output "subnet_details" {
  description = "Detailed information about all subnets"
  value       = { for k, v in data.aws_subnet.details : k => {
    id                = v.id
    vpc_id            = v.vpc_id
    cidr_block        = v.cidr_block
    availability_zone = v.availability_zone
    map_public_ip_on_launch = v.map_public_ip_on_launch
  } }
}

output "all_route_tables" {
  description = "List of all route table IDs in the region"
  value       = data.aws_route_tables.all.ids
}

output "all_internet_gateways" {
  description = "List of all internet gateway IDs attached to VPCs"
  value       = [for igw in data.aws_internet_gateway.attached : igw.internet_gateway_id]
}

output "all_internet_gateway_details" {
  description = "Detailed information about internet gateways"
  value       = { for k, v in data.aws_internet_gateway.attached : k => {
    id        = v.internet_gateway_id
    attached  = true
    vpc_id    = k
    owner_id  = v.owner_id
    state     = length(v.attachments) > 0 ? v.attachments[0].state : "unknown"
  } }
}

output "all_nat_gateways" {
  description = "List of all NAT gateway IDs in the region"
  value       = data.aws_nat_gateways.all.ids
}

output "all_security_groups" {
  description = "List of all security group IDs in the region"
  value       = data.aws_security_groups.all.ids
}

output "all_network_acls" {
  description = "List of all network ACL IDs in the region"
  value       = data.aws_network_acls.all.ids
}

output "all_eips" {
  description = "List of all Elastic IP addresses in the region"
  value       = data.aws_eips.all.public_ips
}

output "all_ec2_instances" {
  description = "List of all EC2 instance IDs in the region"
  value       = data.aws_instances.all.ids
}

# Count outputs
output "vpc_count" {
  description = "Number of VPCs found"
  value       = length(data.aws_vpcs.all.ids)
}

output "subnet_count" {
  description = "Number of subnets found"
  value       = length(data.aws_subnets.all.ids)
}

output "route_table_count" {
  description = "Number of route tables found"
  value       = length(data.aws_route_tables.all.ids)
}

output "internet_gateway_count" {
  description = "Number of internet gateways found"
  value       = length([for igw in data.aws_internet_gateway.attached : igw.internet_gateway_id])
}

output "nat_gateway_count" {
  description = "Number of NAT gateways found"
  value       = length(data.aws_nat_gateways.all.ids)
}

output "security_group_count" {
  description = "Number of security groups found"
  value       = length(data.aws_security_groups.all.ids)
}

output "instance_count" {
  description = "Number of EC2 instances found"
  value       = length(data.aws_instances.all.ids)
}

output "eip_count" {
  description = "Number of Elastic IPs found"
  value       = length(data.aws_eips.all.public_ips)
}

output "network_acl_count" {
  description = "Number of network ACLs found"
  value       = length(data.aws_network_acls.all.ids)
}
