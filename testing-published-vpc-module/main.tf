provider "aws" {
  region = "us-east-1"
}

module "custom-module" {
  source  = "bhargav2800/custom-module/vpc"
  version = "1.0.1"

  vpc_config = {
    cidr_block = "10.0.0.0/16"
    name       = "my-test-vpc"
  }

  subnet_config = {
    public_subnet-0 = {
      cidr_block = "10.0.2.0/24"
      az = "us-east-1a"
      public = true
    },
    public_subnet = {
      cidr_block = "10.0.0.0/24"
      az = "us-east-1a"
      public = true
    },
    private_subnet = {
      cidr_block = "10.0.1.0/24"
      az = "us-east-1b"
    }
  }
}