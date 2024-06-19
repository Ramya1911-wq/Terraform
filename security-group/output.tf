output "sg_id" {
  value = aws_security_group.sg.id
}

output "rds_sg" {
  value = aws_security_group.rds_sg.id
}
