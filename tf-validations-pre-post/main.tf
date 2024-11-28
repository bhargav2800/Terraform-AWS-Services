terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.54.1"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "my-vpc"
  }
}

resource "aws_subnet" "private" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.0.0/24"
}

resource "aws_security_group" "main" {
  name = "my-sg"
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "main" {
  ami = "ami-0866a3c8686eaeeba"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.private.id
  associate_public_ip_address = false
  depends_on = [aws_security_group.main]

  lifecycle {
    precondition {
      condition = aws_security_group.main.id != ""
      error_message = "Security Group ID must not be blank."
    }

    postcondition {
      condition = self.public_ip != ""
      error_message = "Public IP is not present."
    }
  }
}
