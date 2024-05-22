locals {
  bucket_naming     =  (var.force_name == "") ? "${var.stage}-${var.owner}-${var.purpose}" : var.force_name
  bucket_visibility = !(var.public || var.static_website)
}

resource "aws_s3_bucket" "main_bucket" {
  bucket = local.bucket_naming

  tags = {
    terraform = true
    stage     = var.stage
    owner     = var.owner
  }
}

# access block
resource "aws_s3_bucket_public_access_block" "bucket_access_block" {
  bucket = aws_s3_bucket.main_bucket.id

  block_public_acls       = local.bucket_visibility
  block_public_policy     = local.bucket_visibility
  ignore_public_acls      = local.bucket_visibility
  restrict_public_buckets = local.bucket_visibility
}

# versioning
resource "aws_s3_bucket_versioning" "bucket_versioning" {
  count = var.versioning ? 1 : 0

  bucket = aws_s3_bucket.main_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

# policy
resource "aws_s3_bucket_policy" "bucket_policy_for_static_website" {
  count = var.static_website ? 1 : 0

  bucket = aws_s3_bucket.main_bucket.id
  policy = data.aws_iam_policy_document.default_permissions.json
}

data "aws_iam_policy_document" "default_permissions" {
  statement {
    principals {
      type        = "*"
      identifiers = [aws_s3_bucket.main_bucket.id]
    }
    actions = [
      "s3:Get*",
      "s3:List*"
    ]
    resources = [
      aws_s3_bucket.main_bucket.arn,
      "${aws_s3_bucket.main_bucket.arn}/*",
    ]
  }
}

# static website config
resource "aws_s3_bucket_website_configuration" "bucket_statics" {
  count = var.static_website ? 1 : 0

  bucket = aws_s3_bucket.main_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}