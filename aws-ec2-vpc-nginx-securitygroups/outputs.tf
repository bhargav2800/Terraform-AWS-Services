output "demo_instance_public_ip" {
  description="The Public IP address of the EC2 instance"
  value = aws_instance.demo-nginx-ec2-server.public_ip
}

output "instance_url" {
  description="The URL to access the Nginx server"
  value = "http://${aws_instance.demo-nginx-ec2-server.public_ip}"
}