terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.75.0"
    }
    random = {
      source = "hashicorp/random"
      version = "3.6.3"
    }
  }
}

provider "aws" {
  region = var.region
}

locals {
  users_data = yamldecode(file("./users.yaml")).users

  user_policy_map = flatten([for user in local.users_data: [for policy in user.policies : {
    username = user.username
    policy = policy
  }]])
}


# Creating users
resource "aws_iam_user" "users" {
  for_each = toset(local.users_data[*].username)
  name = each.value
}

# Password creation
resource "aws_iam_user_login_profile" "profile" {
  for_each = aws_iam_user.users
  user = each.value.name
  password_length = 12

  lifecycle {
    ignore_changes = [
      password_length,
      password_reset_required,
      pgp_key,
    ]
  }
}

# Attaching policies
resource "aws_iam_user_policy_attachment" "main" {
  for_each = {
    for pair in local.user_policy_map:
        "${pair.username}-${pair.policy}" =>  pair
  }

  user = each.value.username
  policy_arn = "arn:aws:iam::aws:policy/${each.value.policy}"
}

output "output" {
  value = local.user_policy_map
}