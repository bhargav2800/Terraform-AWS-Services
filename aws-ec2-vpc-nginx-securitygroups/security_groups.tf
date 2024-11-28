resource "aws_security_group" "demo-nginx-sg" {
  vpc_id = aws_vpc.demo-vpc.id

  # Inbound traffic
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound traffic
  egress {
    from_port = 0 # means available for all ports
    to_port = 0
    protocol = "-1" # -1 means applicable on al protocol
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "nginx-sg"
  }
}