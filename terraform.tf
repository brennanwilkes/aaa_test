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
      bucket = "terraform-state-dwf02yrjct3m712bi2tv3t4d1mw9x5sl4js6qh9er5apf"
}

resource "aws_instance" "asdasdfas" {
      ami = data.aws_ami.amazon_latest.id
      instance_type = "t2.micro"
      lifecycle {
        ignore_changes = [ami]
      }
      subnet_id = aws_subnet.devxp_vpc_subnet_public0.id
      associate_public_ip_address = true
      vpc_security_group_ids = [aws_security_group.devxp_security_group.id]
      iam_instance_profile = aws_iam_instance_profile.asdasdfas_iam_role_instance_profile.name
}

resource "aws_eip" "asdasdfas_eip" {
      instance = aws_instance.asdasdfas.id
      vpc = true
}

resource "aws_iam_user" "asdasdfas_iam" {
      name = "asdasdfas_iam"
}

resource "aws_iam_user_policy_attachment" "asdasdfas_iam_policy_attachment0" {
      user = aws_iam_user.asdasdfas_iam.name
      policy_arn = aws_iam_policy.asdasdfas_iam_policy0.arn
}

resource "aws_iam_policy" "asdasdfas_iam_policy0" {
      name = "asdasdfas_iam_policy0"
      path = "/"
      policy = data.aws_iam_policy_document.asdasdfas_iam_policy_document.json
}

resource "aws_iam_access_key" "asdasdfas_iam_access_key" {
      user = aws_iam_user.asdasdfas_iam.name
}

resource "aws_dynamodb_table" "asdf" {
      name = "asdf"
      hash_key = "asdf"
      billing_mode = "PAY_PER_REQUEST"
      ttl {
        attribute_name = "TimeToExist"
        enabled = true
      }
      attribute {
        name = "asdf"
        type = "S"
        _id = "622865ffc9042c5c872d4c5e"
      }
}

resource "aws_iam_user" "asdf_iam" {
      name = "asdf_iam"
}

resource "aws_iam_user_policy_attachment" "asdf_iam_policy_attachment0" {
      user = aws_iam_user.asdf_iam.name
      policy_arn = aws_iam_policy.asdf_iam_policy0.arn
}

resource "aws_iam_policy" "asdf_iam_policy0" {
      name = "asdf_iam_policy0"
      path = "/"
      policy = data.aws_iam_policy_document.asdf_iam_policy_document.json
}

resource "aws_iam_access_key" "asdf_iam_access_key" {
      user = aws_iam_user.asdf_iam.name
}

resource "aws_iam_instance_profile" "asdasdfas_iam_role_instance_profile" {
      name = "asdasdfas_iam_role_instance_profile"
      role = aws_iam_role.asdasdfas_iam_role.name
}

resource "aws_iam_role" "asdasdfas_iam_role" {
      name = "asdasdfas_iam_role"
      assume_role_policy = "{\n  \"Version\": \"2012-10-17\",\n  \"Statement\": [\n    {\n      \"Action\": \"sts:AssumeRole\",\n      \"Principal\": {\n        \"Service\": \"ec2.amazonaws.com\"\n      },\n      \"Effect\": \"Allow\",\n      \"Sid\": \"\"\n    }\n  ]\n}"
}

resource "aws_iam_role_policy_attachment" "asdasdfas_iam_role_asdf_iam_policy0_attachment" {
      policy_arn = aws_iam_policy.asdf_iam_policy0.arn
      role = aws_iam_role.asdasdfas_iam_role.name
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

data "aws_iam_policy_document" "asdasdfas_iam_policy_document" {
      statement {
        actions = ["ec2:RunInstances", "ec2:AssociateIamInstanceProfile", "ec2:ReplaceIamInstanceProfileAssociation"]
        effect = "Allow"
        resources = ["arn:aws:ec2:::*"]
      }
      statement {
        actions = ["iam:PassRole"]
        effect = "Allow"
        resources = [aws_instance.asdasdfas.arn]
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

data "aws_iam_policy_document" "asdf_iam_policy_document" {
      statement {
        actions = ["dynamodb:DescribeTable", "dynamodb:Query", "dynamodb:Scan", "dynamodb:BatchGet*", "dynamodb:DescribeStream", "dynamodb:DescribeTable", "dynamodb:Get*", "dynamodb:Query", "dynamodb:Scan", "dynamodb:BatchWrite*", "dynamodb:CreateTable", "dynamodb:Delete*", "dynamodb:Update*", "dynamodb:PutItem"]
        effect = "Allow"
        resources = [aws_dynamodb_table.asdf.arn]
      }
      statement {
        actions = ["dynamodb:List*", "dynamodb:DescribeReservedCapacity*", "dynamodb:DescribeLimits", "dynamodb:DescribeTimeToLive"]
        effect = "Allow"
        resources = ["*"]
      }
}

