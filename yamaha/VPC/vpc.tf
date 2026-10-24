resource "aws_vpc" "test_vpc" {
  cidr_block = "10.0.0.0/20"

  tags = {
    Name = "Test_vpc"
  }
}


resource "aws_subnet" "test_public_subnet_1" {
  vpc_id                  = aws_vpc.test_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "test_public_subnet_1"
  }
}


resource "aws_subnet" "test_public_subnet_2" {
  vpc_id                  = aws_vpc.test_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "test_public_subnet_2"
  }
}


resource "aws_subnet" "test_private_subnet_1" {
  vpc_id            = aws_vpc.test_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "test_private_subnet_1"
  }
}


resource "aws_internet_gateway" "test_igw" {
  vpc_id = aws_vpc.test_vpc.id

  tags = {
    Name = "test_igw"
  }
}


resource "aws_route_table" "test_rt" {
  vpc_id = aws_vpc.test_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.test_igw.id
  }

  tags = {
    Name = "test_rt"
  }
}


resource "aws_route_table_association" "routeassociation1" {
  route_table_id = aws_route_table.test_rt.id
  subnet_id      = aws_subnet.test_public_subnet_1.id
}


resource "aws_route_table_association" "routeassociation2" {
  route_table_id = aws_route_table.test_rt.id
  subnet_id      = aws_subnet.test_public_subnet_2.id
}