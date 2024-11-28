terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.75.0"
    }
  }
}

# Number list
variable "num_list" {
  type = list(number)
  default = [1, 2, 3, 4, 5]
}

# Object list of person
variable "person_list" {
  type = list(object({
    fname=string
    lname=string
  }))
  default = [{
    fname:"Bhargav"
    lname:"Patel"
  }, {
    fname:"Raju"
    lname:"Rastogi"
  }]
}

# Map List
variable "map_list" {
  type = map(number)
  default = {
    "one": 1
    "two": 2
    "three": 3
  }
}

# Calculations
locals {
  mul = 2*2
  add = 2+2
  eq = 2!=3

  double = [for num in var.num_list: (num * 2)]

  odd = [for num in var.num_list: num if num%2 != 0]

  fnames = [for name in var.person_list: name.fname]

  map_keys = [for key,value in var.map_list: key]

  double_map = { for key,value in var.map_list: key => value * 2 }
}

output "output" {
  value = local.double_map
}