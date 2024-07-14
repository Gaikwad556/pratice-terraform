resource "aws_vpc" "vprovpc" {
  cidr_block       = var.CIDR
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "vprovpc"
  }
}

resource "aws_subnet" "pub_1" {
  vpc_id     = aws_vpc.vprovpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = var.ZONE1
  map_public_ip_on_launch = true

  tags = {
    Name = "pub_1"
  }
}

resource "aws_subnet" "pub_2" {
  vpc_id     = aws_vpc.vprovpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = var.ZONE2
  map_public_ip_on_launch = true

  tags = {
    Name = "pub_2"
  }
}

resource "aws_subnet" "priv_1" {
  vpc_id     = aws_vpc.vprovpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = var.ZONE1
  map_public_ip_on_launch = true

  tags = {
    Name = "priv_1"
  }
}

resource "aws_subnet" "priv_2" {
  vpc_id     = aws_vpc.vprovpc.id
  cidr_block = "10.0.4.0/24"
  availability_zone = var.ZONE2
  map_public_ip_on_launch = true

  tags = {
    Name = "priv_2"
  }
}


resource "aws_internet_gateway" "gw_vpro" {
  vpc_id = aws_vpc.vprovpc.id

  tags = {
    Name = "gw_vpro"
  }
}

resource "aws_route_table" "route_vpro" {
  vpc_id = aws_vpc.vprovpc.id

  route {
    cidr_block = "10.0.1.0/24"
    gateway_id = aws_internet_gateway.gw_vpro.id
  }
}

resource "aws_route_table_association" "pub_1_rwa" {
  subnet_id      = aws_subnet.pub_1.id
  route_table_id = aws_route_table.route_vpro.id
}

resource "aws_route_table_association" "pub_2_rwa" {
  subnet_id      = aws_subnet.pub_2.id
  route_table_id = aws_route_table.route_vpro.id
}