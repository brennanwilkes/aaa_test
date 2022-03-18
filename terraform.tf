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
      bucket = "terraform-state-wiwua8zmjq3mwpt2vwx6nbzr3u7gf20mc25h4s2wrx8vx"
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

resource "aws_instance" "Instance-Enet" {
      ami = data.aws_ami.amazon_latest.id
      instance_type = "t2.micro"
      lifecycle {
        ignore_changes = [ami]
      }
      subnet_id = aws_subnet.devxp_vpc_subnet_public0.id
      associate_public_ip_address = true
      vpc_security_group_ids = [aws_security_group.devxp_security_group.id]
      iam_instance_profile = aws_iam_instance_profile.Instance-Enet_iam_role_instance_profile.name
}

resource "aws_eip" "Instance-Enet_eip" {
      instance = aws_instance.Instance-Enet.id
      vpc = true
}

resource "aws_iam_user" "Instance-Enet_iam" {
      name = "Instance-Enet_iam"
}

resource "aws_iam_user_policy_attachment" "Instance-Enet_iam_policy_attachment0" {
      user = aws_iam_user.Instance-Enet_iam.name
      policy_arn = aws_iam_policy.Instance-Enet_iam_policy0.arn
}

resource "aws_iam_policy" "Instance-Enet_iam_policy0" {
      name = "Instance-Enet_iam_policy0"
      path = "/"
      policy = data.aws_iam_policy_document.Instance-Enet_iam_policy_document.json
}

resource "aws_iam_access_key" "Instance-Enet_iam_access_key" {
      user = aws_iam_user.Instance-Enet_iam.name
}

resource "aws_instance" "Instance-rlkc" {
      ami = data.aws_ami.ubuntu_latest.id
      instance_type = "t2.large"
      lifecycle {
        ignore_changes = [ami]
      }
      subnet_id = aws_subnet.devxp_vpc_subnet_public0.id
      associate_public_ip_address = true
      vpc_security_group_ids = [aws_security_group.devxp_security_group.id]
      iam_instance_profile = aws_iam_instance_profile.Instance-rlkc_iam_role_instance_profile.name
}

resource "aws_eip" "Instance-rlkc_eip" {
      instance = aws_instance.Instance-rlkc.id
      vpc = true
}

resource "aws_iam_user" "Instance-rlkc_iam" {
      name = "Instance-rlkc_iam"
}

resource "aws_iam_user_policy_attachment" "Instance-rlkc_iam_policy_attachment0" {
      user = aws_iam_user.Instance-rlkc_iam.name
      policy_arn = aws_iam_policy.Instance-rlkc_iam_policy0.arn
}

resource "aws_iam_policy" "Instance-rlkc_iam_policy0" {
      name = "Instance-rlkc_iam_policy0"
      path = "/"
      policy = data.aws_iam_policy_document.Instance-rlkc_iam_policy_document.json
}

resource "aws_iam_access_key" "Instance-rlkc_iam_access_key" {
      user = aws_iam_user.Instance-rlkc_iam.name
}

resource "aws_dynamodb_table" "asdf" {
      name = "asdf"
      hash_key = "asdfDAFADF"
      billing_mode = "PAY_PER_REQUEST"
      ttl {
        attribute_name = "TimeToExist"
        enabled = true
      }
      attribute {
        name = "asdfDAFADF"
        type = "S"
        _id = "62295acfb6f05f8866e135a6"
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

resource "aws_iam_instance_profile" "Instance-Enet_iam_role_instance_profile" {
      name = "Instance-Enet_iam_role_instance_profile"
      role = aws_iam_role.Instance-Enet_iam_role.name
}

resource "aws_iam_instance_profile" "Instance-rlkc_iam_role_instance_profile" {
      name = "Instance-rlkc_iam_role_instance_profile"
      role = aws_iam_role.Instance-rlkc_iam_role.name
}

resource "aws_iam_role" "asdasdfas_iam_role" {
      name = "asdasdfas_iam_role"
      assume_role_policy = "{\n  \"Version\": \"2012-10-17\",\n  \"Statement\": [\n    {\n      \"Action\": \"sts:AssumeRole\",\n      \"Principal\": {\n        \"Service\": \"ec2.amazonaws.com\"\n      },\n      \"Effect\": \"Allow\",\n      \"Sid\": \"\"\n    }\n  ]\n}"
}

resource "aws_iam_role" "Instance-Enet_iam_role" {
      name = "Instance-Enet_iam_role"
      assume_role_policy = "{\n  \"Version\": \"2012-10-17\",\n  \"Statement\": [\n    {\n      \"Action\": \"sts:AssumeRole\",\n      \"Principal\": {\n        \"Service\": \"ec2.amazonaws.com\"\n      },\n      \"Effect\": \"Allow\",\n      \"Sid\": \"\"\n    }\n  ]\n}"
}

resource "aws_iam_role" "Instance-rlkc_iam_role" {
      name = "Instance-rlkc_iam_role"
      assume_role_policy = "{\n  \"Version\": \"2012-10-17\",\n  \"Statement\": [\n    {\n      \"Action\": \"sts:AssumeRole\",\n      \"Principal\": {\n        \"Service\": \"ec2.amazonaws.com\"\n      },\n      \"Effect\": \"Allow\",\n      \"Sid\": \"\"\n    }\n  ]\n}"
}

resource "aws_iam_role_policy_attachment" "asdasdfas_iam_role_asdf_iam_policy0_attachment" {
      policy_arn = aws_iam_policy.asdf_iam_policy0.arn
      role = aws_iam_role.asdasdfas_iam_role.name
}

resource "aws_iam_role_policy_attachment" "Instance-Enet_iam_role_asdf_iam_policy0_attachment" {
      policy_arn = aws_iam_policy.asdf_iam_policy0.arn
      role = aws_iam_role.Instance-Enet_iam_role.name
}

resource "aws_iam_role_policy_attachment" "Instance-rlkc_iam_role_asdf_iam_policy0_attachment" {
      policy_arn = aws_iam_policy.asdf_iam_policy0.arn
      role = aws_iam_role.Instance-rlkc_iam_role.name
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

data "aws_iam_policy_document" "Instance-Enet_iam_policy_document" {
      statement {
        actions = ["ec2:RunInstances", "ec2:AssociateIamInstanceProfile", "ec2:ReplaceIamInstanceProfileAssociation"]
        effect = "Allow"
        resources = ["arn:aws:ec2:::*"]
      }
      statement {
        actions = ["iam:PassRole"]
        effect = "Allow"
        resources = [aws_instance.Instance-Enet.arn]
      }
}

data "aws_iam_policy_document" "Instance-rlkc_iam_policy_document" {
      statement {
        actions = ["ec2:RunInstances", "ec2:AssociateIamInstanceProfile", "ec2:ReplaceIamInstanceProfileAssociation"]
        effect = "Allow"
        resources = ["arn:aws:ec2:::*"]
      }
      statement {
        actions = ["iam:PassRole"]
        effect = "Allow"
        resources = [aws_instance.Instance-rlkc.arn]
      }
}

data "aws_ami" "ubuntu_latest" {
      most_recent = true
      owners = ["099720109477"]
      filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64*"]
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

