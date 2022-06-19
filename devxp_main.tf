terraform {
  backend "s3" {
      bucket = "terraform-state-8abgyu1531iuxlohl6dog6r3j0slg7t4eny2eq8wwj577"
      key = "terraform/state"
      region = "us-west-2"
  }
}

resource "aws_s3_bucket" "bucket-uxgl-rxsj-rxpa-kmrt-zdke" {
      bucket = "bucket-uxgl-rxsj-rxpa-kmrt-zdke"
}

resource "aws_s3_bucket_public_access_block" "bucket-uxgl-rxsj-rxpa-kmrt-zdke_access" {
      bucket = aws_s3_bucket.bucket-uxgl-rxsj-rxpa-kmrt-zdke.id
      block_public_acls = true
      block_public_policy = true
}




