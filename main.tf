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
  region = var.aws_region
}

# VPC
module "vpc" {
  source = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
  vpc_tag  = var.vpc_tag
}

# IGW
module "igw" {
  source = "./modules/igw"
  vpc_id = module.vpc.vpc_id
  igw_tag = var.igw_tag
}


module "subnet" {
  source = "./modules/subnets"
  vpc_id = module.vpc.vpc_id
  subnet1_cidr = var.subnet1_cidr
  subnet1_tag = var.subnet1_tag
  subnet2_cidr = var.subnet2_cidr
  subnet2_tag = var.subnet2_tag
  subnet3_cidr = var.subnet3_cidr
  subnet3_tag = var.subnet3_tag
}


module "route_table" {
  source = "./modules/route_table"
  vpc_id = module.vpc.vpc_id
  public_route_table_cidr = var.public_route_table_cidr
  igw_id = module.igw.igw_id
  kataka_rt_tag = var.public_route_table_tag
}

module "route_table_association" {
  source = "./modules/route_table_association"
  subnet1_id = module.subnet.subnet_id_1
  subnet2_id = module.subnet.subnet_id_2
  subnet3_id = module.subnet.subnet_id_3
  route_table_id = module.route_table.route_table_id
}


module "security_group" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id
  security_group_tag = var.security_group_tag
}

module "ec2" {
  source = "./modules/ec2"
  subnet_id = module.subnet.subnet_id_1
  security_group_id = module.security_group.security_group_id
  ami = var.ami
  instance_type = var.instance_type
  instance_tag = var.instance_tag
}


