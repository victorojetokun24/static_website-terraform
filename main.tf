# Main Configurations
resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name
}


resource "aws_s3_bucket_public_access_block" "my_bucket_public_access_block" {
  bucket = aws_s3_bucket.my_bucket.id

  block_public_acls   = false
  block_public_policy = false
  ignore_public_acls  = false
  restrict_public_buckets = false
}


resource "aws_s3_bucket_policy" "my_bucket_policy" {
  bucket = aws_s3_bucket.my_bucket.bucket
  policy = data.aws_iam_policy_document.s3_policy.json
  # policy = aws_iam_policy.s3_policy.arn
}

module "template_file" {
  source   = "hashicorp/dir/template"
  base_dir = "${path.module}/webfiles"
}

resource "aws_s3_bucket_website_configuration" "web-config" {
  bucket = aws_s3_bucket.my_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_object" "bucket_files" {
  bucket = aws_s3_bucket.my_bucket.id

  for_each     = module.template_file.files
  key          = each.key
  content_type = each.value.content_type

  source  = each.value.source_path
  content = each.value.content

  etag = each.value.digests.md5
}


resource "aws_cloudfront_distribution" "my_distribution" {
  enabled             = true
  aliases             = [var.domain_name]
  default_root_object = "index.html"
  is_ipv6_enabled     = true
  wait_for_deployment = true


  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD", "OPTIONS"]
    cache_policy_id        = "658327ea-f89d-4fab-a63d-7e88639e58f6"
    target_origin_id       = aws_s3_bucket.my_bucket.bucket
    viewer_protocol_policy = "redirect-to-https"

  }

  viewer_certificate {
    acm_certificate_arn      = var.acm_certificate_arn
    minimum_protocol_version = "TLSv1.2_2021"
    ssl_support_method       = "sni-only"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  origin {
    domain_name = aws_s3_bucket.my_bucket.bucket_regional_domain_name
    origin_id   = aws_s3_bucket.my_bucket.id
  }


}

resource "aws_cloudfront_origin_access_control" "main" {
  name                              = "my-bucket-access-control"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"

}

resource "aws_cloudfront_origin_access_identity" "main" {
  comment = "Access identity for my-bucket"
}



# terraform init
# terraform validate
# terraform fmt
# ter
# terraform plan
# terraform apply -auto-approve
# terraform destroy -auto-approve
