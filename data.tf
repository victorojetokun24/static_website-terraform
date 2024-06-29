data "aws_caller_identity" "current" {}

data "aws_route53_zone" "selected" {
  zone_id = var.route53_zone_id
}
