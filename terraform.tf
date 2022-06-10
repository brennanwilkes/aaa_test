terraform {
  backend "s3" {
      bucket = "terraform-state-9rxwi9n13v5pkqmddykjimrfr91pvxzl6l81ohjfhv0an"
      key = "terraform/state"
      region = "us-west-2"
  }
}

provider "aws" {
    region = "us-west-2"
}

resource "aws_instance" "Instance-jjoj" {
      ami = data.aws_ami.ubuntu_latest.id
      instance_type = "t2.micro"
      lifecycle {
        ignore_changes = [ami]
      }
      subnet_id = aws_subnet.devxp_vpc_subnet_public0.id
      associate_public_ip_address = true
      vpc_security_group_ids = [aws_security_group.devxp_security_group.id]
      iam_instance_profile = aws_iam_instance_profile.Instance-jjoj_iam_role_instance_profile.name
}

resource "aws_eip" "Instance-jjoj_eip" {
      vpc = true
      instance = aws_instance.Instance-jjoj.id
}

resource "aws_iam_user" "Instance-jjoj_iam" {
      name = "Instance-jjoj_iam"
}

resource "aws_iam_user_policy_attachment" "Instance-jjoj_iam_policy_attachment0" {
      user = aws_iam_user.Instance-jjoj_iam.name
      policy_arn = aws_iam_policy.Instance-jjoj_iam_policy0.arn
}

resource "aws_iam_policy" "Instance-jjoj_iam_policy0" {
      name = "Instance-jjoj_iam_policy0"
      path = "/"
      policy = data.aws_iam_policy_document.Instance-jjoj_iam_policy_document.json
}

resource "aws_iam_access_key" "Instance-jjoj_iam_access_key" {
      user = aws_iam_user.Instance-jjoj_iam.name
}

resource "aws_s3_bucket" "bucket-pqvl-wxfb-nhnh-mabm-yscf" {
      bucket = "bucket-pqvl-wxfb-nhnh-mabm-yscf"
}

resource "aws_s3_bucket_public_access_block" "bucket-pqvl-wxfb-nhnh-mabm-yscf_access" {
      bucket = aws_s3_bucket.bucket-pqvl-wxfb-nhnh-mabm-yscf.id
      block_public_acls = true
      block_public_policy = true
}

resource "aws_iam_user" "bucket-pqvl-wxfb-nhnh-mabm-yscf_iam" {
      name = "bucket-pqvl-wxfb-nhnh-mabm-yscf_iam"
}

resource "aws_iam_user_policy_attachment" "bucket-pqvl-wxfb-nhnh-mabm-yscf_iam_policy_attachment0" {
      user = aws_iam_user.bucket-pqvl-wxfb-nhnh-mabm-yscf_iam.name
      policy_arn = aws_iam_policy.bucket-pqvl-wxfb-nhnh-mabm-yscf_iam_policy0.arn
}

resource "aws_iam_policy" "bucket-pqvl-wxfb-nhnh-mabm-yscf_iam_policy0" {
      name = "bucket-pqvl-wxfb-nhnh-mabm-yscf_iam_policy0"
      path = "/"
      policy = data.aws_iam_policy_document.bucket-pqvl-wxfb-nhnh-mabm-yscf_iam_policy_document.json
}

resource "aws_iam_access_key" "bucket-pqvl-wxfb-nhnh-mabm-yscf_iam_access_key" {
      user = aws_iam_user.bucket-pqvl-wxfb-nhnh-mabm-yscf_iam.name
}

resource "aws_iam_instance_profile" "Instance-jjoj_iam_role_instance_profile" {
      name = "Instance-jjoj_iam_role_instance_profile"
      role = aws_iam_role.Instance-jjoj_iam_role.name
}

resource "aws_iam_role" "Instance-jjoj_iam_role" {
      name = "Instance-jjoj_iam_role"
      assume_role_policy = "{\n  \"Version\": \"2012-10-17\",\n  \"Statement\": [\n    {\n      \"Action\": \"sts:AssumeRole\",\n      \"Principal\": {\n        \"Service\": \"ec2.amazonaws.com\"\n      },\n      \"Effect\": \"Allow\",\n      \"Sid\": \"\"\n    }\n  ]\n}"
}

resource "aws_iam_role_policy_attachment" "Instance-jjoj_iam_role_bucket-pqvl-wxfb-nhnh-mabm-yscf_iam_policy0_attachment" {
      policy_arn = aws_iam_policy.bucket-pqvl-wxfb-nhnh-mabm-yscf_iam_policy0.arn
      role = aws_iam_role.Instance-jjoj_iam_role.name
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
      ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
      ingress {
        from_port = 443
        to_port = 443
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

data "aws_iam_policy_document" "Instance-jjoj_iam_policy_document" {
      statement {
        actions = ["ec2:RunInstances", "ec2:AssociateIamInstanceProfile", "ec2:ReplaceIamInstanceProfileAssociation"]
        effect = "Allow"
        resources = ["arn:aws:ec2:::*"]
      }
      statement {
        actions = ["iam:PassRole"]
        effect = "Allow"
        resources = [aws_instance.Instance-jjoj.arn]
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

data "aws_iam_policy_document" "bucket-pqvl-wxfb-nhnh-mabm-yscf_iam_policy_document" {
      statement {
        actions = ["s3:ListAllMyBuckets"]
        effect = "Allow"
        resources = ["arn:aws:s3:::*"]
      }
      statement {
        actions = ["s3:*"]
        effect = "Allow"
        resources = [aws_s3_bucket.bucket-pqvl-wxfb-nhnh-mabm-yscf.arn]
      }
}



