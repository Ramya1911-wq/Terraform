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
  default = "dbuser"
}

variable "password" {
  default = "dbuser123"
}
