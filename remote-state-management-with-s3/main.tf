terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.75.0"
    }
  }

  backend "s3" {
    bucket = "demo-bucket-bhargav-5be74b05ffadb4d9"
    key = "backend.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}

resource "aws_instance" "myserver" {
  ami = "ami-0866a3c8686eaeeba" # Which instance you want to use (Ubuntu, Windows, ...) COpy the AMI id of it and paste it here.
  instance_type = "t2.micro"

  # Optional
  tags = {
    Name = "SampleServer"
  }
}
