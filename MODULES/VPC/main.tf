resource "aws_vpc" "virtual" {
    cidr_block = var.vpc_cidr
    enable_dns_hostnames =   true
    enable_dns_support = true

    tags = {
      Name = "${var.instance_name}-vpc-${var.environment}"
      Environment = var.environment
    }
}

resource "aws_internet_gateway" "IG" {
    vpc_id = aws_vpc.virtual.id

    tags = {
      Name = "${var.instance_name}-igw-${var.environment}"
      Environment = var.environment
    }
}

resource "aws_subnet" "public" {
    vpc_id = aws_vpc.virtual.id
    cidr_block = var.public_subnet_cidr
    availability_zone = var.availability_zone
    map_public_ip_on_launch = true

    tags = {
      Name = "${var.instance_name}-public-subnet-${var.environment}"
      Environment = var.environment
    }
}

resource "aws_subnet" "private" {
    vpc_id = aws_vpc.virtual.id
    cidr_block = var.private_subnet_cidr
    availability_zone = var.availability_zone

    tags = {
      Name = "${var.instance_name}-private-subnet-${var.environment}"
      Environment = var.environment
    }
}

resource "aws_route_table" "table" {
    vpc_id = aws_vpc.virtual.id

    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.IG.id
    }

    tags = {
      Name = "${var.instance_name}-public-rt-${var.environment}"
      Environment = var.environment
    }
}

resource "aws_route_table_association" "public" {
    subnet_id = aws_subnet.public.id
    route_table_id = aws_route_table.table.id
}