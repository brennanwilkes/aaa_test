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



