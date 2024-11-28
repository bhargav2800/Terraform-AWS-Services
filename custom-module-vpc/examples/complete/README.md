This is complete config to work with this module.

USAGE
```
provider "aws" {
  region = "us-east-1"
}

module "my_own_vpc" {
  source = "./custom-modules/vpc"

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

output "vpc" {
  value = module.my_own_vpc.vpc_id
}

output "public_subnet" {
  value = module.my_own_vpc.public_subnets
}

output "private_subnet" {
  value = module.my_own_vpc.private_subnets
}

```