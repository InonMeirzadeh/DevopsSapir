terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region     = "eu-central-1"
  access_key = ""
  secret_key = ""

}
resource "aws_vpc" "InonMeirzadeh-dev-vpc" {
  cidr_block       = "10.0.0.0/24"
  instance_tenancy = "default"

  tags = {
    Name = "Inon-Meirzadeh-dev-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.InonMeirzadeh-dev-vpc.id

  tags = {
    Name = "Inon-Igw"
  }
}

resource "aws_route" "routeIGW" {
  route_table_id         = aws_vpc.InonMeirzadeh-dev-vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_subnet" "Inon-Meirzadeh-k8s-subnet" {
  vpc_id            = aws_vpc.InonMeirzadeh-dev-vpc.id
  cidr_block        = "10.0.0.0/27"
  availability_zone = "eu-central-1a"

  tags = {
    Name = "Inon-Meirzadeh-k8s-subnet "
  }
}


