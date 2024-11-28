terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.75.0"
    }
    random = {
      source = "hashicorp/random"
      version = "3.6.3"
    }
  }
}

provider "aws" {
  # Configuration options
  region = var.region
}

resource "random_id" "rand_id" {
  byte_length = 8
}

resource "aws_s3_bucket" "s3-webapp-bucket" {
  bucket = "demo-bucket-bhargav-${random_id.rand_id.hex}"
}

resource "aws_s3_bucket_public_access_block" "aws_public_access_policy" {
  bucket = aws_s3_bucket.s3-webapp-bucket.id

  block_public_acls = false
  block_public_policy = false
  ignore_public_acls = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "mywebapppolicy" {
  bucket = aws_s3_bucket.s3-webapp-bucket.id
  policy = jsonencode(
    {
      Version = "2012-10-17",
      Statement = [
          {
              Sid = "PublicReadGetObject",
              Effect = "Allow",
              Principal = "*",
              Action = "s3:GetObject",
              Resource = "${aws_s3_bucket.s3-webapp-bucket.arn}/*"
          }
      ]
    }
  )
}

resource "aws_s3_bucket_website_configuration" "mywebapps3config" {
  bucket = aws_s3_bucket.s3-webapp-bucket.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_object" "index_file" {
  bucket = aws_s3_bucket.s3-webapp-bucket.bucket
  source = "static_site/index.html"
  key = "index.html"
  content_type = "text/html"
}

resource "aws_s3_object" "style_file" {
  bucket = aws_s3_bucket.s3-webapp-bucket.bucket
  source = "static_site/styles.css"
  key = "styles.css"
  content_type = "text/css"
}
