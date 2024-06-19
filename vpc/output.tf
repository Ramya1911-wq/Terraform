output "vpc-id" {
  value = aws_vpc.vpc.id
}

output "subnet-id" {
  value = aws_subnet.public.id
}

output "subnet-group-id" {
  value = aws_db_subnet_group.subnet_group.id
}
