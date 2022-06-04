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
      bucket = "terraform-state-9rxwi9n13v5pkqmddykjimrfr91pvxzl6l81ohjfhv0an"
}

resource "aws_iam_role" "Lambda-ptom-lambda-iam-role" {
      name = "Lambda-ptom-lambda-iam-role"
      assume_role_policy = "{\n  \"Version\": \"2012-10-17\",\n  \"Statement\": [\n    {\n      \"Action\": \"sts:AssumeRole\",\n      \"Principal\": {\n        \"Service\": \"lambda.amazonaws.com\"\n      },\n      \"Effect\": \"Allow\",\n      \"Sid\": \"\"\n    }\n  ]\n}"
}

resource "aws_lambda_function" "Lambda-ptom" {
      function_name = "Lambda-ptom"
      role = aws_iam_role.Lambda-ptom-lambda-iam-role.arn
      filename = "outputs/index.js.zip"
      runtime = "nodejs14.x"
      source_code_hash = data.archive_file.Lambda-ptom-archive.output_base64sha256
      handler = "index.main"
}

data "archive_file" "Lambda-ptom-archive" {
      type = "zip"
      source_file = "index.js"
      output_path = "outputs/index.js.zip"
}



