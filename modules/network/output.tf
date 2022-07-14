output "primary_subnet_id" {
  value = aws_subnet.primary-subnet.id
}
output "secondary_subnet_id" {
  value = aws_subnet.secondary-subnet.id
}

output "vpc_id" {
  value = aws_vpc.main.id
}