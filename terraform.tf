terraform {
  backend "s3" {
      bucket = "terraform-state-le087d2qndi3e6ehpz0tzdc3z8ojd35su7sybzbtl3sep"
      key = "terraform/state"
      region = "us-west-2"
  }
}

provider "aws" {
    region = "us-west-2"
}

resource "aws_instance" "myInstance-a" {
      ami = data.aws_ami.ubuntu_latest.id
      instance_type = "t2.small"
      lifecycle {
        ignore_changes = [ami]
      }
      subnet_id = aws_subnet.devxp_vpc_subnet_public0.id
      associate_public_ip_address = true
      vpc_security_group_ids = [aws_security_group.devxp_security_group.id]
      iam_instance_profile = aws_iam_instance_profile.myInstance-a_iam_role_instance_profile.name
      key_name = "myInstance-a_keyPair"
}

resource "aws_eip" "myInstance-a_eip" {
      vpc = true
      instance = aws_instance.myInstance-a.id
}

resource "tls_private_key" "myInstance-a_keyPair_tls_key" {
      algorithm = "RSA"
      rsa_bits = 4096
}

resource "aws_key_pair" "myInstance-a_keyPair" {
      public_key = tls_private_key.myInstance-a_keyPair_tls_key.public_key_openssh
      key_name = "myInstance-a_keyPair"
}

resource "local_sensitive_file" "myInstance-a_keyPair_pem_file" {
      filename = pathexpand("~/.ssh/myInstance-a_keyPair.pem")
      file_permission = "600"
      directory_permission = "700"
      content = tls_private_key.myInstance-a_keyPair_tls_key.private_key_pem
}

resource "aws_iam_user" "myInstance-a_iam" {
      name = "myInstance-a_iam"
}

resource "aws_iam_user_policy_attachment" "myInstance-a_iam_policy_attachment0" {
      user = aws_iam_user.myInstance-a_iam.name
      policy_arn = aws_iam_policy.myInstance-a_iam_policy0.arn
}

resource "aws_iam_policy" "myInstance-a_iam_policy0" {
      name = "myInstance-a_iam_policy0"
      path = "/"
      policy = data.aws_iam_policy_document.myInstance-a_iam_policy_document.json
}

resource "aws_iam_access_key" "myInstance-a_iam_access_key" {
      user = aws_iam_user.myInstance-a_iam.name
}

resource "aws_instance" "myInstance-b" {
      ami = data.aws_ami.ubuntu_latest.id
      instance_type = "t2.small"
      lifecycle {
        ignore_changes = [ami]
      }
      subnet_id = aws_subnet.devxp_vpc_subnet_public0.id
      associate_public_ip_address = true
      vpc_security_group_ids = [aws_security_group.devxp_security_group.id]
      iam_instance_profile = aws_iam_instance_profile.myInstance-b_iam_role_instance_profile.name
      key_name = "myInstance-b_keyPair"
}

resource "aws_eip" "myInstance-b_eip" {
      vpc = true
      instance = aws_instance.myInstance-b.id
}

resource "tls_private_key" "myInstance-b_keyPair_tls_key" {
      algorithm = "RSA"
      rsa_bits = 4096
}

resource "aws_key_pair" "myInstance-b_keyPair" {
      public_key = tls_private_key.myInstance-b_keyPair_tls_key.public_key_openssh
      key_name = "myInstance-b_keyPair"
}

resource "local_sensitive_file" "myInstance-b_keyPair_pem_file" {
      filename = pathexpand("~/.ssh/myInstance-b_keyPair.pem")
      file_permission = "600"
      directory_permission = "700"
      content = tls_private_key.myInstance-b_keyPair_tls_key.private_key_pem
}

resource "aws_iam_user" "myInstance-b_iam" {
      name = "myInstance-b_iam"
}

resource "aws_iam_user_policy_attachment" "myInstance-b_iam_policy_attachment0" {
      user = aws_iam_user.myInstance-b_iam.name
      policy_arn = aws_iam_policy.myInstance-b_iam_policy0.arn
}

resource "aws_iam_policy" "myInstance-b_iam_policy0" {
      name = "myInstance-b_iam_policy0"
      path = "/"
      policy = data.aws_iam_policy_document.myInstance-b_iam_policy_document.json
}

resource "aws_iam_access_key" "myInstance-b_iam_access_key" {
      user = aws_iam_user.myInstance-b_iam.name
}

resource "aws_iam_instance_profile" "myInstance-a_iam_role_instance_profile" {
      name = "myInstance-a_iam_role_instance_profile"
      role = aws_iam_role.myInstance-a_iam_role.name
}

resource "aws_iam_instance_profile" "myInstance-b_iam_role_instance_profile" {
      name = "myInstance-b_iam_role_instance_profile"
      role = aws_iam_role.myInstance-b_iam_role.name
}

resource "aws_iam_role" "myInstance-a_iam_role" {
      name = "myInstance-a_iam_role"
      assume_role_policy = "{\n  \"Version\": \"2012-10-17\",\n  \"Statement\": [\n    {\n      \"Action\": \"sts:AssumeRole\",\n      \"Principal\": {\n        \"Service\": \"ec2.amazonaws.com\"\n      },\n      \"Effect\": \"Allow\",\n      \"Sid\": \"\"\n    }\n  ]\n}"
}

resource "aws_iam_role" "myInstance-b_iam_role" {
      name = "myInstance-b_iam_role"
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

data "aws_iam_policy_document" "myInstance-a_iam_policy_document" {
      statement {
        actions = ["ec2:RunInstances", "ec2:AssociateIamInstanceProfile", "ec2:ReplaceIamInstanceProfileAssociation"]
        effect = "Allow"
        resources = ["arn:aws:ec2:::*"]
      }
      statement {
        actions = ["iam:PassRole"]
        effect = "Allow"
        resources = [aws_instance.myInstance-a.arn]
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

data "aws_iam_policy_document" "myInstance-b_iam_policy_document" {
      statement {
        actions = ["ec2:RunInstances", "ec2:AssociateIamInstanceProfile", "ec2:ReplaceIamInstanceProfileAssociation"]
        effect = "Allow"
        resources = ["arn:aws:ec2:::*"]
      }
      statement {
        actions = ["iam:PassRole"]
        effect = "Allow"
        resources = [aws_instance.myInstance-b.arn]
      }
}


output "myInstance-a-public-ip" {
    value = aws_instance.myInstance-a.public_ip
    sensitive = false
}

output "myInstance-a_eip-public-ip" {
    value = aws_eip.myInstance-a_eip.*.public_ip
    sensitive = false
}

output "myInstance-a_keyPair-private_key" {
    value = tls_private_key.myInstance-a_keyPair_tls_key.private_key_pem
    sensitive = true
}

output "myInstance-a-ssh_instructions" {
    value = "To access myInstance-a, use: ssh -i ~/.ssh/myInstance-a_keyPair.pem ubuntu@${aws_eip.myInstance-a.*.public_ip}"
    sensitive = false
}

output "myInstance-b-public-ip" {
    value = aws_instance.myInstance-b.public_ip
    sensitive = false
}

