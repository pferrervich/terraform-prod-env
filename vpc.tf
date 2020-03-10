resource "aws_vpc" "vpc" {
  cidr_block           = "${var.cidr}"
  enable_dns_hostnames = false
  enable_dns_support   = false
  tags = {
    Name = "aperture"
  }
}

# public subnet configs
resource "aws_subnet" "pub1" {
  cidr_block = "${var.pub1_cidr}"
  vpc_id     = "${aws_vpc.vpc.id}"
  # instances with public ip
  map_public_ip_on_launch = true
  # where we want to be deployed
  availability_zone = "${data.aws_availability_zones.avazones.names[0]}"
  tags = {
    Name = "pub1"
  }
}

resource "aws_subnet" "pub2" {
  cidr_block              = "${var.pub2_cidr}"
  vpc_id                  = "${aws_vpc.vpc.id}"
  map_public_ip_on_launch = true
  availability_zone       = "${data.aws_availability_zones.avazones.names[1]}"
  tags = {
    Name = "pub2"
  }
}

# priv subnet configs
resource "aws_subnet" "pri1" {
  cidr_block              = "${var.pri1_cidr}"
  vpc_id                  = "${aws_vpc.vpc.id}"
  map_public_ip_on_launch = true
  availability_zone       = "${data.aws_availability_zones.avazones.names[0]}"
  tags = {
    Name = "pri1"
  }
}

resource "aws_subnet" "pri2" {
  cidr_block              = "${var.pri2_cidr}"
  vpc_id                  = "${aws_vpc.vpc.id}"
  map_public_ip_on_launch = true
  availability_zone       = "${data.aws_availability_zones.avazones.names[1]}"
  tags = {
    Name = "pri2"
  }
}

# gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"
}

# defaults all traffic to igw
resource "aws_route" "default" {
  # did not create a route table, but in each vpc a default table is created
  route_table_id = "${aws_vpc.vpc.default_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.igw.id}"
}
