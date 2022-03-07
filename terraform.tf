terraform {
  required_providers {
    aws =  {
    source = "hashicorp/aws"
    version = ">= 2.7.0"
    }
  }
}

provider "aws" {
    region = "us-west-2"
}

resource "aws_s3_bucket" "terraform_backend_bucket" {
      bucket = "terraform-state-7stxwjd0yfl3aumq9qm8bgxa1mh43jcgl4b6897dv3u6o"
}

resource "aws_subnet" "devxp_vpc_subnet_private" {
      vpc_id = aws_vpc.devxp_vpc.id
      cidr_block = "10.0.128.0/24"
      map_public_ip_on_launch = false
      availability_zone = "us-west-2a"
}

resource "aws_route_table" "devxp_vpc_routetable_priv" {
      vpc_id = aws_vpc.devxp_vpc.id
}

resource "aws_route_table_association" "devxp_vpc_subnet_private_assoc" {
      subnet_id = aws_subnet.devxp_vpc_subnet_private.id
      route_table_id = aws_route_table.devxp_vpc_routetable_priv.id
}

resource "aws_subnet" "devxp_vpc_subnet_public" {
      vpc_id = aws_vpc.devxp_vpc.id
      cidr_block = "10.0.0.0/24"
      map_public_ip_on_launch = true
      availability_zone = "us-west-2a"
}

resource "aws_internet_gateway" "devxp_vpc_internetgateway" {
      vpc_id = aws_vpc.devxp_vpc.id
}

resource "aws_route_table" "devxp_vpc_routetable_pub" {
      route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.devxp_vpc_internetgateway.id
      }
      vpc_id = aws_vpc.devxp_vpc.id
}

resource "aws_route" "devxp_vpc_internet_route" {
      route_table_id = aws_route_table.devxp_vpc_routetable_pub.id
      destination_cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.devxp_vpc_internetgateway.id
}

resource "aws_route_table_association" "devxp_vpc_subnet_public_assoc" {
      subnet_id = aws_subnet.devxp_vpc_subnet_public.id
      route_table_id = aws_route_table.devxp_vpc_routetable_pub.id
}

resource "aws_vpc" "devxp_vpc" {
      cidr_block = "10.0.0.0/16"
      enable_dns_support = true
      enable_dns_hostnames = true
}

resource "aws_security_group" "devxp_security_group" {
      vpc_id = aws_vpc.devxp_vpc.id
      name = "devxp_security_group"
      ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
      egress = []
}

data = []
