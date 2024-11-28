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

locals {
  owner = "ABC"
  name = "MyServer"
}

resource "aws_instance" "myserver" {
  ami = "ami-0866a3c8686eaeeba"
  instance_type = var.aws_instance_type

  root_block_device {
    delete_on_termination = true
    volume_size = var.ec2_config.v_size
    volume_type = var.ec2_config.v_type
  }

  # It will add Name = "SampleServer" tag in additional_tags coming from variable.
  tags = merge(var.additional_tags, {
    Name = local.name
    owner = local.owner
  })
}