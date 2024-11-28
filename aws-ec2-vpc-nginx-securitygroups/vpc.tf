resource "aws_vpc" "demo-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
      Name = "demo_vpc"
  }
}

# Private Subnet
resource "aws_subnet" "demo-private-subnet" {
  vpc_id = aws_vpc.demo-vpc.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "private-subnet"
  }
}

# Public Subnet
resource "aws_subnet" "demo-public-subnet" {
  vpc_id = aws_vpc.demo-vpc.id
  cidr_block = "10.0.2.0/24"
  tags = {
    Name = "public-subnet"
  }
}

# Internet gateway
resource "aws_internet_gateway" "demo-igw" {
  vpc_id = aws_vpc.demo-vpc.id
  tags = {
    Name = "demo-igw"
  }
}

# Routing table
resource "aws_route_table" "demo-rt" {
  vpc_id = aws_vpc.demo-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo-igw.id
  }
}

# Associate public subnet with vpc routing of (0.0.0.0/0) to give access of internet gateway(Public access) for 0.0.0.0/0 bunch of ips.
resource "aws_route_table_association" "demo-public-sub" {
  route_table_id = aws_route_table.demo-rt.id
  subnet_id = aws_subnet.demo-public-subnet.id
}
