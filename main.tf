terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  backend "s3" {
    bucket = "kataka-state-bucket-001"
    key    = "kataka.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}


# ====================== VPC ==================
resource "aws_vpc" "kataka_vpc" {
  cidr_block       = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "kataka_vpc"
  }
}


# ====================== Internet Gateway ==================
resource "aws_internet_gateway" "kataka_igw" {
  vpc_id = aws_vpc.kataka_vpc.id

  tags = {
    Name = "kataka_igw"
  }
}


# ====================== Subnets ==================
resource "aws_subnet" "kataka_public_subnet_1_1a" {
  vpc_id     = aws_vpc.kataka_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "kataka_public_subnet_1_1a"
  }
}

resource "aws_subnet" "kataka_public_subnet_2_1a" {
  vpc_id     = aws_vpc.kataka_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "kataka_public_subnet_2_1a"
  }
}

resource "aws_subnet" "kataka_public_subnet_3_1b" {
  vpc_id     = aws_vpc.kataka_vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "kataka_public_subnet_3_1b"
  }
}

#  ====================== Route Table ==================
resource "aws_route_table" "kataka_public_route_table" {
  vpc_id = aws_vpc.kataka_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.kataka_igw.id
  }

  tags = {
    Name = "kataka_public_route_table"
  }
}

# ====================== Route Table Association ==================
resource "aws_route_table_association" "kataka_public_route_table_association_1" {
  subnet_id      = aws_subnet.kataka_public_subnet_1_1a.id
  route_table_id = aws_route_table.kataka_public_route_table.id
}

resource "aws_route_table_association" "kataka_public_route_table_association_2" {
  subnet_id      = aws_subnet.kataka_public_subnet_2_1a.id
  route_table_id = aws_route_table.kataka_public_route_table.id
}

resource "aws_route_table_association" "kataka_public_route_table_association_3" {
  subnet_id      = aws_subnet.kataka_public_subnet_3_1b.id
  route_table_id = aws_route_table.kataka_public_route_table.id
}

# ====================== Security Group ==================
resource "aws_security_group" "kataka_security_group" {
  name        = "kataka_security_group"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.kataka_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "kataka_security_group"
  }
}
