locals {
  network = yamldecode(file("${path.module}/network.yaml"))
}

resource "aws_vpc" "studioX-vpc" {
  instance_tenancy                 = "default"
  # cidr_block                       = local.network.cidr_block
  cidr_block = var.vpc_cidr
  enable_dns_hostnames             = true
  assign_generated_ipv6_cidr_block = true
  tags = {
    Name = "studioX"
  }


}
data "aws_availability_zones" "available_zones" {}


resource "aws_subnet" "studioX-pub-sub1" {
  vpc_id                          = aws_vpc.studioX-vpc.id
  availability_zone               = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch         = true
  assign_ipv6_address_on_creation = true
  cidr_block                      = var.pub_sub1_cidr

  tags = {
    Name = "studioX-frontend(A)"
  }

  //This lets aws pick from IPAM pool
  ipv6_cidr_block = cidrsubnet(aws_vpc.studioX-vpc.ipv6_cidr_block, 4, 1)

  //This is something I am experimenting on
  # for_each = { for s in local.network.subnets : s.name => s }
  # ipv6_cidr_block         = each.value.ipv6_cidr_block
}

resource "aws_subnet" "studioX-pub-sub2" {

  vpc_id                          = aws_vpc.studioX-vpc.id
  availability_zone               = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch         = true
  assign_ipv6_address_on_creation = true
  cidr_block                      = var.pub_sub2_cidr
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.studioX-vpc.ipv6_cidr_block, 4, 2)
  tags = {
    Name = "studioX-frontend(B)"
  }

}

resource "aws_subnet" "datasync-subnet" {

  vpc_id                          = aws_vpc.studioX-vpc.id
  availability_zone               = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch         = true
  assign_ipv6_address_on_creation = true
  cidr_block                      = var.datasnc_cidr
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.studioX-vpc.ipv6_cidr_block, 4, 3)
  tags = {
    Name = "datasync-subnet"
  }

}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.studioX-vpc.id

}

resource "aws_route_table" "studioX-rtb" {
  vpc_id = aws_vpc.studioX-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "studioX-internet-rtb"
  }
}

resource "aws_route_table_association" "pub_sub1_association" {
  //This is for the above experiment 
  # for_each        = aws_subnet.studioX-pub-sub1
  subnet_id      = aws_subnet.studioX-pub-sub1.id
  route_table_id = aws_route_table.studioX-rtb.id
}

resource "aws_route_table_association" "datasnc_association" {
  subnet_id = aws_subnet.datasync-subnet.id
  route_table_id = aws_route_table.studioX-rtb.id
}