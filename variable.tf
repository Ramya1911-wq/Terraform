provider "aws" {
  region = "us-east-1"
}

variable "resoursename" {
  default = "webproject"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "username" {
  type = string
  description = "RDS user name"
  default = "dbuser"
}

variable "password" {
  type = string
  description = "RDS password"
  default = "dbuser123"
}
