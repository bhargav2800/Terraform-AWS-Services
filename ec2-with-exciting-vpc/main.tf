terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.75.0"
    }
  }
}

provider "aws" {
  region = var.region
}

# security group
data "aws_security_group" "demo_security_group" {
  tags = {
    mywebserver = "http"
  }
}

# VPC
data "aws_vpc" "demo_vpc" {
  tags = {
    Name = "my-demo-vpc"
  }
}

# Subnet
data "aws_subnet" "demo_private_subnet" {
  filter {
    name = "vpc-id"
    values = [ data.aws_vpc.demo_vpc.id ]
  }
  tags = {
    Name = "my-demo-private-subnet"
  }
}

resource "aws_instance" "myserver" {
  ami = "ami-0453ec754f44f9a4a" # Amazon Linux machine ami
  instance_type = "t2.micro"
  subnet_id = data.aws_subnet.demo_private_subnet.id
  security_groups = [ data.aws_security_group.demo_security_group.id ]

  # Optional
  tags = {
    Name = "SampleServer"
  }
}