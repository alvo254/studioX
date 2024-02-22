output "vpc_id" {
    value = aws_vpc.studioX-vpc.id
}
output "subnet_id" {
  value = aws_subnet.studioX-pub-sub1.id
}