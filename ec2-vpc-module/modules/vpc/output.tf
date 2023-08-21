output "vpc_id" {
    description = "ID of VPC to use in server"
    value = aws_vpc.vpctf.id
}

output "publicSubnet" {
  value = aws_subnet.publicSubnet.id
}

output "privateSubnet" {
  value = aws_subnet.privateSubnet.id
}

