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
      bucket = "terraform-state-g97m690walt4ahbcdxh9t2t627qjd5hhftjc3bkbur0jn"
}

resource "aws_instance" "Instance-npbh" {
      ami = "ami-0faefa03f7ddcd657"
      instance_type = "mac1.metal"
      subnet_id = aws_subnet.devxp_vpc_subnet_public0.id
      associate_public_ip_address = true
      vpc_security_group_ids = [aws_security_group.devxp_security_group.id]
      iam_instance_profile = aws_iam_instance_profile.Instance-npbh_iam_role_instance_profile.name
}

resource "aws_eip" "Instance-npbh_eip" {
      vpc = true
      instance = aws_instance.Instance-npbh.id
}

resource "aws_iam_user" "Instance-npbh_iam" {
      name = "Instance-npbh_iam"
}

resource "aws_iam_user_policy_attachment" "Instance-npbh_iam_policy_attachment0" {
      user = aws_iam_user.Instance-npbh_iam.name
      policy_arn = aws_iam_policy.Instance-npbh_iam_policy0.arn
}

resource "aws_iam_policy" "Instance-npbh_iam_policy0" {
      name = "Instance-npbh_iam_policy0"
      path = "/"
      policy = data.aws_iam_policy_document.Instance-npbh_iam_policy_document.json
}

resource "aws_iam_access_key" "Instance-npbh_iam_access_key" {
      user = aws_iam_user.Instance-npbh_iam.name
}

resource "aws_iam_role" "Lambda-exvi-lambda-iam-role" {
      name = "Lambda-exvi-lambda-iam-role"
      assume_role_policy = "{\n  \"Version\": \"2012-10-17\",\n  \"Statement\": [\n    {\n      \"Action\": \"sts:AssumeRole\",\n      \"Principal\": {\n        \"Service\": \"lambda.amazonaws.com\"\n      },\n      \"Effect\": \"Allow\",\n      \"Sid\": \"\"\n    }\n  ]\n}"
}

resource "aws_lambda_function" "Lambda-exvi" {
      function_name = "Lambda-exvi"
      role = aws_iam_role.Lambda-exvi-lambda-iam-role.arn
      filename = "outputs/index.js.zip"
      runtime = "nodejs14.x"
      source_code_hash = data.archive_file.Lambda-exvi-archive.output_base64sha256
      handler = "index.main"
      vpc_config {
        subnet_ids = [aws_subnet.devxp_vpc_subnet_public0.id]
        security_group_ids = [aws_security_group.devxp_security_group.id]
      }
}

resource "aws_iam_policy" "Lambda-exvi-vpc-policy" {
      name = "Lambda-exvi_vpc_policy"
      path = "/"
      policy = data.aws_iam_policy_document.Lambda-exvi-vpc-policy-document.json
}

resource "aws_iam_role_policy_attachment" "Lambda-exvi-vpc-policy-attachment" {
      policy_arn = aws_iam_policy.Lambda-exvi-vpc-policy.arn
      role = aws_iam_role.Lambda-exvi-lambda-iam-role.name
}

resource "aws_iam_instance_profile" "Instance-npbh_iam_role_instance_profile" {
      name = "Instance-npbh_iam_role_instance_profile"
      role = aws_iam_role.Instance-npbh_iam_role.name
}

resource "aws_iam_role" "Instance-npbh_iam_role" {
      name = "Instance-npbh_iam_role"
      assume_role_policy = "{\n  \"Version\": \"2012-10-17\",\n  \"Statement\": [\n    {\n      \"Action\": \"sts:AssumeRole\",\n      \"Principal\": {\n        \"Service\": \"ec2.amazonaws.com\"\n      },\n      \"Effect\": \"Allow\",\n      \"Sid\": \"\"\n    }\n  ]\n}"
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
      egress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
      egress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
}

data "aws_iam_policy_document" "Instance-npbh_iam_policy_document" {
      statement {
        actions = ["ec2:RunInstances", "ec2:AssociateIamInstanceProfile", "ec2:ReplaceIamInstanceProfileAssociation"]
        effect = "Allow"
        resources = ["arn:aws:ec2:::*"]
      }
      statement {
        actions = ["iam:PassRole"]
        effect = "Allow"
        resources = [aws_instance.Instance-npbh.arn]
      }
}

data "archive_file" "Lambda-exvi-archive" {
      type = "zip"
      source_file = "index.js"
      output_path = "outputs/index.js.zip"
}

data "aws_iam_policy_document" "Lambda-exvi-vpc-policy-document" {
      statement {
        effect = "Allow"
        actions = ["ec2:DescribeSecurityGroups", "ec2:DescribeSubnets", "ec2:DescribeVpcs", "logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents", "ec2:CreateNetworkInterface", "ec2:DescribeNetworkInterfaces", "ec2:DeleteNetworkInterface"]
        resources = ["*"]
      }
}



