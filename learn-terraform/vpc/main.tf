resource "aws_vpc" "project-vpc" {
  cidr_block       = "10.0.0.0/16"

  tags = {
    Name = "Project-vpc"
  }
}

resource "aws_subnet" "Public-Subnet" {
  vpc_id     = aws_vpc.project-vpc.id
  cidr_block = "10.0.0.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1d"

  tags = {
    Name = "Public-Subnet"
  }
}

resource "aws_subnet" "Private-Subnet" {
  vpc_id     = aws_vpc.project-vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1d"

  tags = {
    Name = "Private-Subnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.project-vpc.id

  tags = {
    Name = "my-igw"
  }
}

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.project-vpc.id

  route {
    cidr_block = "10.0.0.0/16"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-rt"
  }
}

resource "aws_route_table_association" "public-rt-subnet-assn" {
  subnet_id      = aws_subnet.Public-Subnet.id
  route_table_id = aws_route_table.public-rt.id
}


resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.project-vpc.id

  route {
    cidr_block = "10.0.0.0/16"

  }

  tags = {
    Name = "private-rt"
  }
}

resource "aws_route_table_association" "prvt-rt-assn" {
  subnet_id      = aws_subnet.Private-Subnet.id
  route_table_id = aws_route_table.private-rt.id
}
