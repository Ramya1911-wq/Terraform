output "public-ip" {
  value = module.ec2.public-ip
}

output "private-key" {
  value     = module.ec2.private-key
  sensitive = true
}

output "rds_endpoint" {
  value = module.rdb.rds_endpoint
}
