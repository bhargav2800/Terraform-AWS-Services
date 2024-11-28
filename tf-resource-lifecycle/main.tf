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
  depends_on = [aws_security_group.main]

  lifecycle {
    # Default behaviour : destroy_before_create
    create_before_destroy = true

    # It will prevent from destroy. fro important resources.
    prevent_destroy = true

    # We can prevent re-run on some properties.
    ignore_changes = []

    # If any change will happen in defined properties it will re run and create again.
    replace_triggered_by = [aws_security_group.main, aws_security_group.main.ingress]
  }
}
