# To show the public ip of our created instance from the main.tf file.
output "aws_instance_public_ip" {
  value = aws_instance.myserver.public_ip
}

