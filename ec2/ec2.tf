resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "{var.resoursename}-key"
  public_key = tls_private_key.example.public_key_openssh
}

data "aws_ami" "amazon_linux_2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}

resource "aws_instance" "web" {
  ami                         = data.aws_ami.amazon_linux_2.id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.generated_key.key_name
  subnet_id                   = var.subnet-id
  associate_public_ip_address = true
  root_block_device {
    volume_size           = "15"
    encrypted             = true
    delete_on_termination = true
  }

  tags = {
    Name = "${var.resoursename}-server"
  }

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras install docker -y
              service docker start
              usermod -a -G docker ec2-user
              docker pull ramya1911/application:1.0
              docker run -d -p 80:80 ramya1911/application:1.0
              EOF

  vpc_security_group_ids = [var.sg-id]

}
