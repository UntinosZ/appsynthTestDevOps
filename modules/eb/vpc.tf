resource "aws_vpc" "main" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags {
    Name = "${var.customer}"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "${var.customer}"
  }
}

resource "aws_subnet" "public1a" {
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "${cidrsubnet(var.vpc_cidr, 2, 0)}"
  map_public_ip_on_launch = true
  availability_zone       = "${element(var.availability_zones, 0)}"
  depends_on              = ["aws_internet_gateway.main"]

  tags {
    Name     = "${var.customer}-public-1a"
  }
}

resource "aws_subnet" "public1b" {
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "${cidrsubnet(var.vpc_cidr, 2, 1)}"
  map_public_ip_on_launch = true
  availability_zone       = "${element(var.availability_zones, 1)}"
  depends_on              = ["aws_internet_gateway.main"]
  
  tags {
    Name     = "${var.customer}-public-1b"
  }
}

resource "aws_subnet" "private1a" {
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "${cidrsubnet(var.vpc_cidr, 2, 2)}"
  map_public_ip_on_launch = false
  availability_zone       = "${element(var.availability_zones, 0)}"
  depends_on              = ["aws_internet_gateway.main"]

  tags {
    Name     = "${var.customer}-private-1a"
  }
}

resource "aws_subnet" "private1b" {
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "${cidrsubnet(var.vpc_cidr, 2, 3)}"
  map_public_ip_on_launch = false
  availability_zone       = "${element(var.availability_zones, 1)}"
  depends_on = ["aws_internet_gateway.main"]

  tags {
    Name     = "${var.customer}-private-1b"
  }
}

resource "aws_default_route_table" "main" {
  default_route_table_id = "${aws_vpc.main.default_route_table_id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main.id}"
  }

  tags {
    Name     = "${var.customer}-public_route"
  }
}

resource "aws_route_table_association" "public1a" {
  subnet_id      = "${aws_subnet.public1a.id}"
  route_table_id = "${aws_default_route_table.main.id}"
}

resource "aws_route_table_association" "public1b" {
  subnet_id      = "${aws_subnet.public1b.id}"
  route_table_id = "${aws_default_route_table.main.id}"
}

resource "aws_eip" "public1a" {
  vpc        = true
  depends_on = ["aws_internet_gateway.main"]
}

resource "aws_eip" "public1b" {
  vpc        = true
  depends_on = ["aws_internet_gateway.main"]
}

resource "aws_nat_gateway" "natpublic1a" {
  allocation_id   = "${aws_eip.public1a.id}"
  subnet_id       = "${aws_subnet.public1a.id}"
  depends_on      = ["aws_internet_gateway.main"]
  tags {
    Name = "${var.customer}-nat-public-1a"
  }
}

resource "aws_nat_gateway" "natpublic1b" {
  allocation_id   = "${aws_eip.public1b.id}"
  subnet_id       = "${aws_subnet.public1b.id}"
  depends_on      = ["aws_internet_gateway.main"]
  tags {
    Name = "${var.customer}-nat-public-1b"
  }
}

resource "aws_route_table" "private_route_table_private1a" {
    vpc_id          = "${aws_vpc.main.id}"

    route {
      cidr_block = "0.0.0.0/0"
      gateway_id  = "${aws_nat_gateway.natpublic1a.id}"
    }
    
    tags {
        Name = "${var.customer}-public-1a"
    }
}

resource "aws_route_table" "private_route_table_private1b" {
    vpc_id          = "${aws_vpc.main.id}"

    route {
      cidr_block = "0.0.0.0/0"
      gateway_id  = "${aws_nat_gateway.natpublic1b.id}"
    }

    tags {
        Name = "${var.customer}-public-1b"
    }
}

resource "aws_route_table_association" "private1a" {
  subnet_id      = "${aws_subnet.private1a.id}"
  route_table_id = "${aws_route_table.private_route_table_private1a.id}"
}

resource "aws_route_table_association" "private1b" {
  subnet_id      = "${aws_subnet.private1b.id}"
  route_table_id = "${aws_route_table.private_route_table_private1b.id}"
}