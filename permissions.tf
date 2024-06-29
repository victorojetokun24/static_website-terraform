# Permission and Policies
data "aws_iam_policy_document" "s3_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.my_bucket.arn}/*"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }

  statement {
    effect    = "Allow"
    actions   = ["s3:PutBucketPolicy"]
    resources = ["arn:aws:s3:::${var.bucket_name}"]

    principals {
      type        = "*"
      identifiers = ["*"]
    
    }
  }
}