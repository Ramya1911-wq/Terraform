output "public-ip" {
  value = aws_instance.web.public_ip
}

output "private-key" {
  value     = tls_private_key.example.private_key_pem
  sensitive = true
}
