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
      bucket = "terraform-state-2wef2zd2rvkiij95eh57h4wvqkifbl5dvip5rwxam7udg"
}

resource "aws_iam_role" "Lambda-HLMs-lambda-iam-role" {
      name = "Lambda-HLMs-lambda-iam-role"
      assume_role_policy = "{\n  \"Version\": \"2012-10-17\",\n  \"Statement\": [\n    {\n      \"Action\": \"sts:AssumeRole\",\n      \"Principal\": {\n        \"Service\": \"lambda.amazonaws.com\"\n      },\n      \"Effect\": \"Allow\",\n      \"Sid\": \"\"\n    }\n  ]\n}"
}

resource "aws_lambda_function" "Lambda-HLMs" {
      function_name = "Lambda-HLMs"
      role = aws_iam_role.Lambda-HLMs-lambda-iam-role.arn
      filename = "outputs/test.js.zip"
      runtime = "nodejs14.x"
      source_code_hash = data.archive_file.Lambda-HLMs-archive.output_base64sha256
      handler = "test.test"
      vpc_config {
        subnet_ids = [aws_subnet.devxp_vpc_subnet_public0.id]
        security_group_ids = [aws_security_group.devxp_security_group.id]
      }
}

resource "aws_iam_policy" "Lambda-HLMs-vpc-policy" {
      name = "Lambda-HLMs_vpc_policy"
      path = "/"
      policy = data.aws_iam_policy_document.Lambda-HLMs-vpc-policy-document.json
}

resource "aws_iam_role_policy_attachment" "Lambda-HLMs-vpc-policy-attachment" {
      policy_arn = aws_iam_policy.Lambda-HLMs-vpc-policy.arn
      role = aws_iam_role.Lambda-HLMs-lambda-iam-role.name
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

data "archive_file" "Lambda-HLMs-archive" {
      type = "zip"
      source_file = "test.js"
      output_path = "outputs/test.js.zip"
}

data "aws_iam_policy_document" "Lambda-HLMs-vpc-policy-document" {
      statement {
        effect = "Allow"
        actions = ["ec2:DescribeSecurityGroups", "ec2:DescribeSubnets", "ec2:DescribeVpcs", "logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents", "ec2:CreateNetworkInterface", "ec2:DescribeNetworkInterfaces", "ec2:DeleteNetworkInterface"]
        resources = ["*"]
      }
}

