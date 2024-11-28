# Create Ec2 with VPC-Subnet (Private or Public)
resource "aws_instance" "demo-nginx-ec2-server" {
  ami = "ami-0866a3c8686eaeeba" # Which instance you want to use (Ubuntu, Windows, ...) COpy the AMI id of it and paste it here.
  instance_type = "t2.micro"
  subnet_id = aws_subnet.demo-public-subnet.id # It will assign ip from pool of public subnet ips("10.0.2.0/24").

  # Mention security group
  vpc_security_group_ids = [aws_security_group.demo-nginx-sg.id]

  # Means provide one public ip to this instance
  associate_public_ip_address = true

  # Pass the bash script which you want to run on ec2 server.
  # Here we are installing nginx and running it on ubuntu server
  user_data = file("ec2_script.sh")

  tags = {
    Name = "DemoNginxEc2Server"
  }
}