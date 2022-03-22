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
      bucket = "terraform-state-ml9ipgtiwmjkhwrpq2nm2y5q9mjl8pjzi2849kh6pf4vm"
}

resource "aws_instance" "Instance-YAGk" {
      ami = data.aws_ami.ubuntu_latest.id
      instance_type = "c3.2xlarge"
      lifecycle {
        ignore_changes = [ami]
      }
      subnet_id = aws_subnet.devxp_vpc_subnet_public0.id
      associate_public_ip_address = true
      vpc_security_group_ids = [aws_security_group.devxp_security_group.id]
      iam_instance_profile = aws_iam_instance_profile.Instance-YAGk_iam_role_instance_profile.name
}

resource "aws_eip" "Instance-YAGk_eip" {
      vpc = true
      instace = aws_instance.Instance-YAGk.id
}

resource "aws_iam_user" "Instance-YAGk_iam" {
      name = "Instance-YAGk_iam"
}

resource "aws_iam_user_policy_attachment" "Instance-YAGk_iam_policy_attachment0" {
      user = aws_iam_user.Instance-YAGk_iam.name
      policy_arn = aws_iam_policy.Instance-YAGk_iam_policy0.arn
}

resource "aws_iam_policy" "Instance-YAGk_iam_policy0" {
      name = "Instance-YAGk_iam_policy0"
      path = "/"
      policy = data.aws_iam_policy_document.Instance-YAGk_iam_policy_document.json
}

resource "aws_iam_access_key" "Instance-YAGk_iam_access_key" {
      user = aws_iam_user.Instance-YAGk_iam.name
}

resource "aws_instance" "Instance-pUnY" {
      ami = data.aws_ami.ubuntu_latest.id
      instance_type = "t2.small"
      lifecycle {
        ignore_changes = [ami]
      }
      subnet_id = aws_subnet.devxp_vpc_subnet_public0.id
      associate_public_ip_address = true
      vpc_security_group_ids = [aws_security_group.devxp_security_group.id]
      iam_instance_profile = aws_iam_instance_profile.Instance-pUnY_iam_role_instance_profile.name
}

resource "aws_eip" "Instance-pUnY_eip" {
      vpc = true
      instace = aws_instance.Instance-pUnY.id
}

resource "aws_iam_user" "Instance-pUnY_iam" {
      name = "Instance-pUnY_iam"
}

resource "aws_iam_user_policy_attachment" "Instance-pUnY_iam_policy_attachment0" {
      user = aws_iam_user.Instance-pUnY_iam.name
      policy_arn = aws_iam_policy.Instance-pUnY_iam_policy0.arn
}

resource "aws_iam_policy" "Instance-pUnY_iam_policy0" {
      name = "Instance-pUnY_iam_policy0"
      path = "/"
      policy = data.aws_iam_policy_document.Instance-pUnY_iam_policy_document.json
}

resource "aws_iam_access_key" "Instance-pUnY_iam_access_key" {
      user = aws_iam_user.Instance-pUnY_iam.name
}

resource "aws_s3_bucket" "Bucket-UyEI-dHZR-FboQ-pWMC-EXBc" {
      bucket = "Bucket-UyEI-dHZR-FboQ-pWMC-EXBc"
}

resource "aws_s3_bucket_public_access_block" "Bucket-UyEI-dHZR-FboQ-pWMC-EXBc_access" {
      bucket = aws_s3_bucket.Bucket-UyEI-dHZR-FboQ-pWMC-EXBc.id
      block_public_acls = true
      block_public_policy = true
}

resource "aws_iam_user" "Bucket-UyEI-dHZR-FboQ-pWMC-EXBc_iam" {
      name = "Bucket-UyEI-dHZR-FboQ-pWMC-EXBc_iam"
}

resource "aws_iam_user_policy_attachment" "Bucket-UyEI-dHZR-FboQ-pWMC-EXBc_iam_policy_attachment0" {
      user = aws_iam_user.Bucket-UyEI-dHZR-FboQ-pWMC-EXBc_iam.name
      policy_arn = aws_iam_policy.Bucket-UyEI-dHZR-FboQ-pWMC-EXBc_iam_policy0.arn
}

resource "aws_iam_policy" "Bucket-UyEI-dHZR-FboQ-pWMC-EXBc_iam_policy0" {
      name = "Bucket-UyEI-dHZR-FboQ-pWMC-EXBc_iam_policy0"
      path = "/"
      policy = data.aws_iam_policy_document.Bucket-UyEI-dHZR-FboQ-pWMC-EXBc_iam_policy_document.json
}

resource "aws_iam_access_key" "Bucket-UyEI-dHZR-FboQ-pWMC-EXBc_iam_access_key" {
      user = aws_iam_user.Bucket-UyEI-dHZR-FboQ-pWMC-EXBc_iam.name
}

resource "aws_iam_instance_profile" "Instance-YAGk_iam_role_instance_profile" {
      name = "Instance-YAGk_iam_role_instance_profile"
      role = aws_iam_role.Instance-YAGk_iam_role.name
}

resource "aws_iam_instance_profile" "Instance-pUnY_iam_role_instance_profile" {
      name = "Instance-pUnY_iam_role_instance_profile"
      role = aws_iam_role.Instance-pUnY_iam_role.name
}

resource "aws_iam_role" "Instance-YAGk_iam_role" {
      name = "Instance-YAGk_iam_role"
      assume_role_policy = "{\n  \"Version\": \"2012-10-17\",\n  \"Statement\": [\n    {\n      \"Action\": \"sts:AssumeRole\",\n      \"Principal\": {\n        \"Service\": \"ec2.amazonaws.com\"\n      },\n      \"Effect\": \"Allow\",\n      \"Sid\": \"\"\n    }\n  ]\n}"
}

resource "aws_iam_role" "Instance-pUnY_iam_role" {
      name = "Instance-pUnY_iam_role"
      assume_role_policy = "{\n  \"Version\": \"2012-10-17\",\n  \"Statement\": [\n    {\n      \"Action\": \"sts:AssumeRole\",\n      \"Principal\": {\n        \"Service\": \"ec2.amazonaws.com\"\n      },\n      \"Effect\": \"Allow\",\n      \"Sid\": \"\"\n    }\n  ]\n}"
}

resource "aws_iam_role_policy_attachment" "Instance-YAGk_iam_role_Bucket-UyEI-dHZR-FboQ-pWMC-EXBc_iam_policy0_attachment" {
      policy_arn = aws_iam_policy.Bucket-UyEI-dHZR-FboQ-pWMC-EXBc_iam_policy0.arn
      role = aws_iam_role.Instance-YAGk_iam_role.name
}

resource "aws_iam_role_policy_attachment" "Instance-pUnY_iam_role_Bucket-UyEI-dHZR-FboQ-pWMC-EXBc_iam_policy0_attachment" {
      policy_arn = aws_iam_policy.Bucket-UyEI-dHZR-FboQ-pWMC-EXBc_iam_policy0.arn
      role = aws_iam_role.Instance-pUnY_iam_role.name
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

data "aws_iam_policy_document" "Instance-YAGk_iam_policy_document" {
      statement {
        actions = ["ec2:RunInstances", "ec2:AssociateIamInstanceProfile", "ec2:ReplaceIamInstanceProfileAssociation"]
        effect = "Allow"
        resources = ["arn:aws:ec2:::*"]
      }
      statement {
        actions = ["iam:PassRole"]
        effect = "Allow"
        resources = [aws_instance.Instance-YAGk.arn]
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

data "aws_iam_policy_document" "Instance-pUnY_iam_policy_document" {
      statement {
        actions = ["ec2:RunInstances", "ec2:AssociateIamInstanceProfile", "ec2:ReplaceIamInstanceProfileAssociation"]
        effect = "Allow"
        resources = ["arn:aws:ec2:::*"]
      }
      statement {
        actions = ["iam:PassRole"]
        effect = "Allow"
        resources = [aws_instance.Instance-pUnY.arn]
      }
}

data "aws_iam_policy_document" "Bucket-UyEI-dHZR-FboQ-pWMC-EXBc_iam_policy_document" {
      statement {
        actions = ["s3:ListAllMyBuckets"]
        effect = "Allow"
        resources = ["arn:aws:s3:::*"]
      }
      statement {
        actions = ["s3:*"]
        effect = "Allow"
        resources = [aws_s3_bucket.Bucket-UyEI-dHZR-FboQ-pWMC-EXBc.arn]
      }
}

