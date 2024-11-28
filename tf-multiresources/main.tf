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
  project = "project-01"
}

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${local.project}-vpc"
  }
}

# Creating 2 subnets using count
resource "aws_subnet" "main" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = "10.0.${count.index}.0/24"
  count = 2
  tags = {
    Name = "${local.project}-subnet-${count.index}"
  }
}

# Create 4 EC2. 2 ec2 in 1st subnet remaining 2 in 2nd subnet using count
resource "aws_instance" "main" {
  ami = "ami-0453ec754f44f9a4a" # Amazon Linux machine ami
  instance_type = "t2.micro"
  count = 4
  subnet_id = element(aws_subnet.main[*].id, count.index % length(aws_subnet.main))

  tags = {
    Name = "${local.project}-instance-${count.index}"
  }
}

# Create 2 EC2. half in 1st subnet and other half in 2nd subnet
resource "aws_instance" "main_for_each" {
  for_each = var.ec2_map
  # We will get each.key and each.value

  ami = each.value.ami
  instance_type = each.value.instance_type
  subnet_id = element(aws_subnet.main[*].id, index(keys(var.ec2_map),each.key) % length(aws_subnet.main))

  tags = {
    Name = "${local.project}-instance-${each.key}"
  }
}

output "aws_subnet_id" {
  value = aws_subnet.main[1].tags
}