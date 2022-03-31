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
      bucket = "terraform-state-dl6f56vzxwr4tm8emzfpdrmwhcgijr2r1w9t83weckmr2"
}

resource "aws_iam_role" "Lambda-zgji-lambda-iam-role" {
      name = "Lambda-zgji-lambda-iam-role"
      assume_role_policy = "{\n  \"Version\": \"2012-10-17\",\n  \"Statement\": [\n    {\n      \"Action\": \"sts:AssumeRole\",\n      \"Principal\": {\n        \"Service\": \"lambda.amazonaws.com\"\n      },\n      \"Effect\": \"Allow\",\n      \"Sid\": \"\"\n    }\n  ]\n}"
}

resource "aws_lambda_function" "Lambda-zgji" {
      function_name = "Lambda-zgji"
      role = aws_iam_role.Lambda-zgji-lambda-iam-role.arn
      filename = "outputs/myFile.js.zip"
      runtime = "nodejs14.x"
      source_code_hash = data.archive_file.Lambda-zgji-archive.output_base64sha256
      handler = "myFile.main"
}

data "archive_file" "Lambda-zgji-archive" {
      type = "zip"
      source_file = "myFile.js"
      output_path = "outputs/myFile.js.zip"
}


