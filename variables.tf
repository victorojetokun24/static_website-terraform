# Variables for the Terraform configuration
variable "region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}


variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
  default     = "vct-s3-bucket"
}

variable "route53_zone_id" {
  description = "The Route 53 Hosted Zone ID"
  type        = string
  default     = "Z08875291T5SBI290Y5AB"
}

variable "domain_name" {
  description = "The domain name for the Route 53 record"
  type        = string
  default     = "vctcode.tech"
}

variable "acm_certificate_arn" {
  description = "The ARN of the ACM certificate"
  type        = string
  default     = "arn:aws:acm:us-east-1:590184021917:certificate/3d267d55-c8bc-48e9-a88a-7b1a35206061"

}
