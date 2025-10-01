provider "aws" {
  region = var.region
}

# Fetch all VPCs
data "aws_vpcs" "all" {}

# Fetch all Subnets across all VPCs
data "aws_subnets" "all" {
  filter {
    name   = "vpc-id"
    values = data.aws_vpcs.all.ids
  }
}

# Fetch all Route Tables across all VPCs
data "aws_route_tables" "all" {
  filter {
    name   = "vpc-id"
    values = data.aws_vpcs.all.ids
  }
}

# Fetch Internet Gateways for each VPC 
data "aws_internet_gateway" "attached" {
  for_each = toset(data.aws_vpcs.all.ids)

  filter {
    name   = "attachment.vpc-id"
    values = [each.value]
  }
}

# Fetch all NAT Gateways
data "aws_nat_gateways" "all" {
  filter {
    name   = "vpc-id"
    values = data.aws_vpcs.all.ids
  }
}

# Fetch all Security Groups
data "aws_security_groups" "all" {
  filter {
    name   = "vpc-id"
    values = data.aws_vpcs.all.ids
  }
}

# Fetch all Network ACLs
data "aws_network_acls" "all" {
  filter {
    name   = "vpc-id"
    values = data.aws_vpcs.all.ids
  }
}

# Elastic IPs
data "aws_eips" "all" {}

# Fetch all EC2 Instances across all VPCs in the region
data "aws_instances" "all" {
  instance_state_names = ["running", "stopped", "stopping", "pending"]
}

# Get VPC details for additional information
data "aws_vpc" "details" {
  for_each = toset(data.aws_vpcs.all.ids)
  id       = each.value
}

# Get subnet details for additional information
data "aws_subnet" "details" {
  for_each = toset(data.aws_subnets.all.ids)
  id       = each.value
}
