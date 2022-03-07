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
      bucket = "terraform-state-d2igw74qq5otg3bvgzlxeygwd21ywihtf0qhy1769rc2d"
}

resource "aws_instance" "asdasdfas" {
      ami = data.aws_ami.amazon_latest.id
      instance_type = "t2.micro"
      lifecycle {
        ignore_changes = [ami]
      }
      subnet_id = aws_subnet.devxp_vpc_subnet_public.id
      associate_public_ip_address = true
      vpc_security_group_ids = [aws_security_group.devxp_security_group.id]
      iam_instance_profile = aws_iam_instance_profile.asdasdfas_iam_role_instance_profile.name
}

resource "aws_eip" "asdasdfas_eip" {
      instance = aws_instance.asdasdfas.id
      vpc = true
}

resource "aws_iam_instance_profile" "asdasdfas_iam_role_instance_profile" {
      name = "asdasdfas_iam_role_instance_profile"
      role = aws_iam_role.asdasdfas_iam_role.name
}

resource "aws_iam_role" "asdasdfas_iam_role" {
      name = "asdasdfas_iam_role"
      assume_role_policy = "{\n  \"Version\": \"2012-10-17\",\n  \"Statement\": [\n    {\n      \"Action\": \"sts:AssumeRole\",\n      \"Principal\": {\n        \"Service\": \"ec2.amazonaws.com\"\n      },\n      \"Effect\": \"Allow\",\n      \"Sid\": \"\"\n    }\n  ]\n}"
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
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
      egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
}

data "aws_ami" "amazon_latest" {
      most_recent = true
      owners = ["585441382316"]
      filter {
        name = "name"
        values = ["*AmazonLinux*"]
      }
      filter {
        name = "virtualization-type"
        values = ["hvm"]
      }
}

