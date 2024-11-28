terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.75.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = var.region
}

resource "aws_instance" "myserver" {
  ami = "ami-0866a3c8686eaeeba" # Which instance you want to use (Ubuntu, Windows, ...) COpy the AMI id of it and paste it here.
  instance_type = "t2.micro"

  # Optional
  tags = {
    Name = "SampleServer"
  }
}