terraform {
  backend "s3" {
      bucket = "terraform-state-8abgyu1531iuxlohl6dog6r3j0slg7t4eny2eq8wwj577"
      key = "terraform/state"
      region = "us-west-2"
  }
}

resource "aws_instance" "Instance-mtdw" {
      ami = data.aws_ami.ubuntu_latest.id
      instance_type = "t2.micro"
      lifecycle {
        ignore_changes = [ami]
      }
}

resource "aws_iam_user" "Instance-mtdw_iam" {
      name = "Instance-mtdw_iam"
}

resource "aws_iam_user_policy_attachment" "Instance-mtdw_iam_policy_attachment0" {
      user = aws_iam_user.Instance-mtdw_iam.name
      policy_arn = aws_iam_policy.Instance-mtdw_iam_policy0.arn
}

resource "aws_iam_policy" "Instance-mtdw_iam_policy0" {
      name = "Instance-mtdw_iam_policy0"
      path = "/"
      policy = data.aws_iam_policy_document.Instance-mtdw_iam_policy_document.json
}

resource "aws_iam_access_key" "Instance-mtdw_iam_access_key" {
      user = aws_iam_user.Instance-mtdw_iam.name
}

data "aws_iam_policy_document" "Instance-mtdw_iam_policy_document" {
      statement {
        actions = ["ec2:RunInstances", "ec2:AssociateIamInstanceProfile", "ec2:ReplaceIamInstanceProfileAssociation"]
        effect = "Allow"
        resources = ["arn:aws:ec2:::*"]
      }
      statement {
        actions = ["iam:PassRole"]
        effect = "Allow"
        resources = [aws_instance.Instance-mtdw.arn]
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



