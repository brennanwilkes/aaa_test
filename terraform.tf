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
      bucket = "terraform-state-0swr9r4s2aum0ee5rk6u7ub1r1i18j7l7q2lg1zgzb6gi"
}

resource "aws_s3_bucket" "asdfasdfasdfasdfasdfasdfASFASFASFASFASF" {
      bucket = "asdfasdfasdfasdfasdfasdfASFASFASFASFASF"
}

resource "aws_s3_bucket_public_access_block" "asdfasdfasdfasdfasdfasdfASFASFASFASFASF_access" {
      bucket = aws_s3_bucket.asdfasdfasdfasdfasdfasdfASFASFASFASFASF.id
      block_public_acls = true
      block_public_policy = true
}

resource "aws_iam_user" "asdfasdfasdfasdfasdfasdfASFASFASFASFASF_iam" {
      name = "asdfasdfasdfasdfasdfasdfASFASFASFASFASF_iam"
}

resource "aws_iam_user_policy_attachment" "asdfasdfasdfasdfasdfasdfASFASFASFASFASF_iam_policy_attachment0" {
      user = aws_iam_user.asdfasdfasdfasdfasdfasdfASFASFASFASFASF_iam.name
      policy_arn = aws_iam_policy.asdfasdfasdfasdfasdfasdfASFASFASFASFASF_iam_policy0.arn
}

resource "aws_iam_policy" "asdfasdfasdfasdfasdfasdfASFASFASFASFASF_iam_policy0" {
      name = "asdfasdfasdfasdfasdfasdfASFASFASFASFASF_iam_policy0"
      path = "/"
      policy = data.aws_iam_policy_document.asdfasdfasdfasdfasdfasdfASFASFASFASFASF_iam_policy_document.json
}

resource "aws_iam_access_key" "asdfasdfasdfasdfasdfasdfASFASFASFASFASF_iam_access_key" {
      user = aws_iam_user.asdfasdfasdfasdfasdfasdfASFASFASFASFASF_iam.name
}

resource "aws_subnet" "devxp_vpc_subnet_public0" {
      vpc_id = aws_vpc.devxp_vpc.id
      cidr_block = "10.0.0.0/25"
      map_public_ip_on_launch = true
      availability_zone = "us-west-2a"
}

resource "aws_subnet" "devxp_vpc_subnet_public1" {
      vpc_id = aws_vpc.devxp_vpc.id
      cidr_block = "10.0.128.0/25"
      map_public_ip_on_launch = true
      availability_zone = "us-west-2b"
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
      subnet_id = aws_subnet.devxp_vpc_subnet_public0.id
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

data "aws_iam_policy_document" "asdfasdfasdfasdfasdfasdfASFASFASFASFASF_iam_policy_document" {
      statement {
        actions = ["s3:ListAllMyBuckets"]
        effect = "Allow"
        resources = ["arn:aws:s3:::*"]
      }
      statement {
        actions = ["s3:*"]
        effect = "Allow"
        resources = [aws_s3_bucket.asdfasdfasdfasdfasdfasdfASFASFASFASFASF.arn]
      }
}

