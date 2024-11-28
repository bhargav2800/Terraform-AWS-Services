# Do not apply it because it might charge you extra so, just run plan command

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

# Fetching existing aws ami(amazon machine image (Like: Linux, Ubuntu.. ami ids ...))
data "aws_ami" "aws_image" {
  most_recent = true
  owners = ["amazon"]
}

# Fetch Security group where tag is mywebserver = http
data "aws_security_group" "security_group" {
  tags = {
    mywebserver = "http"
  }
}

# fetch VPC with filter
data "aws_vpc" "vpc_instance" {
  tags = {
    ENV = "PROD"
  }
}


# Fetch Availability zones
data "aws_availability_zones" "zones" {
  state="available"
}




# Outputs

# We can use this image to creat any EC2 instance.  also if any other fetched then we can as per our requirement.
output "aws_ami" {
  value = data.aws_ami.aws_image.id
}

# fetched security group
output "aws_security_group" {
  value = data.aws_security_group.security_group.id
}

# fetched VPC
output "aws_vpc" {
  value = data.aws_vpc.vpc_instance.id
}

# Fetched available zones
output "aws_availablity_zones" {
  value = data.aws_availability_zones.zones
}