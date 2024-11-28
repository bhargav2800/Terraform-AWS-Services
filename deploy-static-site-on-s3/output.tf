output "site-url" {
  value = aws_s3_bucket_website_configuration.mywebapps3config.website_endpoint
}