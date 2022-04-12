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
      bucket = "terraform-state-dwz7yaaexi9yft4zrqa95mvfpgaybzyd07a6rsngxl27a"
}

resource "aws_instance" "Instance-acwa-a" {
      ami = data.aws_ami.amazon_latest.id
      instance_type = "t2.medium"
      lifecycle {
        ignore_changes = [ami]
      }
      subnet_id = aws_subnet.devxp_vpc_subnet_public0.id
      associate_public_ip_address = true
      vpc_security_group_ids = [aws_security_group.devxp_security_group.id]
      iam_instance_profile = aws_iam_instance_profile.Instance-acwa-a_iam_role_instance_profile.name
}

resource "aws_eip" "Instance-acwa-a_eip" {
      vpc = true
      instance = aws_instance.Instance-acwa-a.id
}

resource "aws_iam_user" "Instance-acwa-a_iam" {
      name = "Instance-acwa-a_iam"
}

resource "aws_iam_user_policy_attachment" "Instance-acwa-a_iam_policy_attachment0" {
      user = aws_iam_user.Instance-acwa-a_iam.name
      policy_arn = aws_iam_policy.Instance-acwa-a_iam_policy0.arn
}

resource "aws_iam_policy" "Instance-acwa-a_iam_policy0" {
      name = "Instance-acwa-a_iam_policy0"
      path = "/"
      policy = data.aws_iam_policy_document.Instance-acwa-a_iam_policy_document.json
}

resource "aws_iam_access_key" "Instance-acwa-a_iam_access_key" {
      user = aws_iam_user.Instance-acwa-a_iam.name
}

resource "aws_instance" "Instance-acwa-b" {
      ami = data.aws_ami.amazon_latest.id
      instance_type = "t2.medium"
      lifecycle {
        ignore_changes = [ami]
      }
      subnet_id = aws_subnet.devxp_vpc_subnet_public0.id
      associate_public_ip_address = true
      vpc_security_group_ids = [aws_security_group.devxp_security_group.id]
      iam_instance_profile = aws_iam_instance_profile.Instance-acwa-b_iam_role_instance_profile.name
}

resource "aws_eip" "Instance-acwa-b_eip" {
      vpc = true
      instance = aws_instance.Instance-acwa-b.id
}

resource "aws_iam_user" "Instance-acwa-b_iam" {
      name = "Instance-acwa-b_iam"
}

resource "aws_iam_user_policy_attachment" "Instance-acwa-b_iam_policy_attachment0" {
      user = aws_iam_user.Instance-acwa-b_iam.name
      policy_arn = aws_iam_policy.Instance-acwa-b_iam_policy0.arn
}

resource "aws_iam_policy" "Instance-acwa-b_iam_policy0" {
      name = "Instance-acwa-b_iam_policy0"
      path = "/"
      policy = data.aws_iam_policy_document.Instance-acwa-b_iam_policy_document.json
}

resource "aws_iam_access_key" "Instance-acwa-b_iam_access_key" {
      user = aws_iam_user.Instance-acwa-b_iam.name
}

resource "aws_instance" "Instance-acwa-c" {
      ami = data.aws_ami.amazon_latest.id
      instance_type = "t2.medium"
      lifecycle {
        ignore_changes = [ami]
      }
      subnet_id = aws_subnet.devxp_vpc_subnet_public0.id
      associate_public_ip_address = true
      vpc_security_group_ids = [aws_security_group.devxp_security_group.id]
      iam_instance_profile = aws_iam_instance_profile.Instance-acwa-c_iam_role_instance_profile.name
}

resource "aws_eip" "Instance-acwa-c_eip" {
      vpc = true
      instance = aws_instance.Instance-acwa-c.id
}

resource "aws_iam_user" "Instance-acwa-c_iam" {
      name = "Instance-acwa-c_iam"
}

resource "aws_iam_user_policy_attachment" "Instance-acwa-c_iam_policy_attachment0" {
      user = aws_iam_user.Instance-acwa-c_iam.name
      policy_arn = aws_iam_policy.Instance-acwa-c_iam_policy0.arn
}

resource "aws_iam_policy" "Instance-acwa-c_iam_policy0" {
      name = "Instance-acwa-c_iam_policy0"
      path = "/"
      policy = data.aws_iam_policy_document.Instance-acwa-c_iam_policy_document.json
}

resource "aws_iam_access_key" "Instance-acwa-c_iam_access_key" {
      user = aws_iam_user.Instance-acwa-c_iam.name
}

resource "aws_iam_instance_profile" "Instance-acwa-a_iam_role_instance_profile" {
      name = "Instance-acwa-a_iam_role_instance_profile"
      role = aws_iam_role.Instance-acwa-a_iam_role.name
}

resource "aws_iam_instance_profile" "Instance-acwa-b_iam_role_instance_profile" {
      name = "Instance-acwa-b_iam_role_instance_profile"
      role = aws_iam_role.Instance-acwa-b_iam_role.name
}

resource "aws_iam_instance_profile" "Instance-acwa-c_iam_role_instance_profile" {
      name = "Instance-acwa-c_iam_role_instance_profile"
      role = aws_iam_role.Instance-acwa-c_iam_role.name
}

resource "aws_iam_role" "Instance-acwa-a_iam_role" {
      name = "Instance-acwa-a_iam_role"
      assume_role_policy = "{\n  \"Version\": \"2012-10-17\",\n  \"Statement\": [\n    {\n      \"Action\": \"sts:AssumeRole\",\n      \"Principal\": {\n        \"Service\": \"ec2.amazonaws.com\"\n      },\n      \"Effect\": \"Allow\",\n      \"Sid\": \"\"\n    }\n  ]\n}"
}

resource "aws_iam_role" "Instance-acwa-b_iam_role" {
      name = "Instance-acwa-b_iam_role"
      assume_role_policy = "{\n  \"Version\": \"2012-10-17\",\n  \"Statement\": [\n    {\n      \"Action\": \"sts:AssumeRole\",\n      \"Principal\": {\n        \"Service\": \"ec2.amazonaws.com\"\n      },\n      \"Effect\": \"Allow\",\n      \"Sid\": \"\"\n    }\n  ]\n}"
}

resource "aws_iam_role" "Instance-acwa-c_iam_role" {
      name = "Instance-acwa-c_iam_role"
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

data "aws_iam_policy_document" "Instance-acwa-a_iam_policy_document" {
      statement {
        actions = ["ec2:RunInstances", "ec2:AssociateIamInstanceProfile", "ec2:ReplaceIamInstanceProfileAssociation"]
        effect = "Allow"
        resources = ["arn:aws:ec2:::*"]
      }
      statement {
        actions = ["iam:PassRole"]
        effect = "Allow"
        resources = [aws_instance.Instance-acwa-a.arn]
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

data "aws_iam_policy_document" "Instance-acwa-b_iam_policy_document" {
      statement {
        actions = ["ec2:RunInstances", "ec2:AssociateIamInstanceProfile", "ec2:ReplaceIamInstanceProfileAssociation"]
        effect = "Allow"
        resources = ["arn:aws:ec2:::*"]
      }
      statement {
        actions = ["iam:PassRole"]
        effect = "Allow"
        resources = [aws_instance.Instance-acwa-b.arn]
      }
}

data "aws_iam_policy_document" "Instance-acwa-c_iam_policy_document" {
      statement {
        actions = ["ec2:RunInstances", "ec2:AssociateIamInstanceProfile", "ec2:ReplaceIamInstanceProfileAssociation"]
        effect = "Allow"
        resources = ["arn:aws:ec2:::*"]
      }
      statement {
        actions = ["iam:PassRole"]
        effect = "Allow"
        resources = [aws_instance.Instance-acwa-c.arn]
      }
}



