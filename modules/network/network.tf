resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "nginx-vpc"
  }
}

resource "aws_internet_gateway" "main-vpc-igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-vpc-igw"
  }
}

resource "aws_subnet" "primary-subnet" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.primary_sub_cidr
  availability_zone = "${var.aws_region}a"
  tags = {
    Name = "Primary-subnet"
  }
}

resource "aws_subnet" "secondary-subnet" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.secondary_sub_cidr
  availability_zone = "${var.aws_region}b"
  tags = {
    Name = "secondary-subnet"
  }
}

resource "aws_route_table" "nginx-vpc-rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main-vpc-igw.id
  }

  tags = {
    Name = "nginx-vpc-rt"
  }
}

resource "aws_route_table_association" "rt-subnet-primary" {
  subnet_id      = aws_subnet.primary-subnet.id
  route_table_id = aws_route_table.nginx-vpc-rt.id
}
resource "aws_route_table_association" "rt-subnet-secondary" {
  subnet_id      = aws_subnet.secondary-subnet.id
  route_table_id = aws_route_table.nginx-vpc-rt.id
}