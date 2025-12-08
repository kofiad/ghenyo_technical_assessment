data "aws_region" "current"{}

resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

resource "aws_eip" "natgw" {
  domain = "vpc"
  tags = {
    Name = "${var.vpc_name}-eip"
  }
}

resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.natgw.id
  subnet_id     = aws_subnet.public-a.id

  tags = {
    Name =  "${var.vpc_name}-natgw"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_subnet" "public-a" {
  vpc_id     = aws_vpc.main.id
  cidr_block = local.public_subnet_a_cidr

  tags = {
    Name = "${var.vpc_name}-public-a"
  }
}

resource "aws_subnet" "public-b" {
  vpc_id     = aws_vpc.main.id
  cidr_block = local.public_subnet_b_cidr

  tags = {
    Name = "${var.vpc_name}-public-b"
  }
}

resource "aws_subnet" "private-a" {
  vpc_id     = aws_vpc.main.id
  cidr_block = local.private_subnet_a_cidr

  tags = {
    Name = "${var.vpc_name}-private-a"
  }
}

resource "aws_subnet" "private-b" {
  vpc_id     = aws_vpc.main.id
  cidr_block = local.private_subnet_b_cidr

  tags = {
    Name = "${var.vpc_name}-private-b"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.vpc_name}-public-route-table"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgw.id
  }

  tags = {
    Name = "${var.vpc_name}-private-route-table"
  }
}

resource "aws_route_table_association" "public-a" {
  subnet_id      = aws_subnet.public-a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public-b" {
  subnet_id      = aws_subnet.public-b.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private-a" {
  subnet_id      = aws_subnet.private-a.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private-b" {
  subnet_id      = aws_subnet.private-b.id
  route_table_id = aws_route_table.private.id
}