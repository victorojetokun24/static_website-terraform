# Result outputs
output "domain" {
  value = aws_cloudfront_distribution.my_distribution.domain_name
}

output "cloudfront_url" {
  value = "https://${aws_cloudfront_distribution.my_distribution.domain_name}"
}

output "website_url" {
  value = aws_s3_bucket_website_configuration.web-config.website_endpoint
}

output "custom_domain" {
  value = "https://${var.domain_name}"
  
}