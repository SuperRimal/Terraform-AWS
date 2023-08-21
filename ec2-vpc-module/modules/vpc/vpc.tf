# Creating network module for server
# 172.0.0.0/16

resource "aws_vpc" "vpctf" {
  cidr_block = var.cidr_block

  tags = {
    "Name" = "vpc-test"
  }
}

# SUBNET - PUBLIC
resource "aws_subnet" "publicSubnet" {
  cidr_block = var.publicSubnet
  vpc_id = aws_vpc.vpctf.id
  map_public_ip_on_launch = true
  availability_zone = var.availabilityzone

  tags ={
    "Name"= "public-test"
  }
}

# SUBNET - PRIVATE
resource "aws_subnet" "privateSubnet" {
  cidr_block = var.privateSubnet
  vpc_id = aws_vpc.vpctf.id
availability_zone = var.availabilityzone
  tags ={
    "Name"= "public-test"
  }
}

# IGW
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpctf.id
  
  tags = {
    "Name" = "igwtf" 
  }
}

# Route table - PUBLIC
resource "aws_route_table" "routePB" {
  vpc_id = aws_vpc.vpctf.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    "Name" = "publicroute"
  }
}

# Route table - PRIVATE
resource "aws_route_table" "routePT" {
  vpc_id = aws_vpc.vpctf.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    "Name" = "privateroute"
  }
}

 # Route table association - public
resource "aws_route_table_association" "assoPB" {
  subnet_id      = aws_subnet.publicSubnet.id
  route_table_id = aws_route_table.routePB.id
}


 # Route table association - private
 resource "aws_route_table_association" "assoPT" {
  subnet_id      = aws_subnet.privateSubnet.id
  route_table_id = aws_route_table.routePT.id
}
