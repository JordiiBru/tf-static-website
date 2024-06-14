module "s3_bucket" {
  source = "git@github.com:JordiiBru/aws-s3-bucket.git?ref=v0.0.2"

  # Common variables
  stage   = var.stage
  owner   = var.owner
  purpose = var.purpose

  # Custom variables
  force_name     = "${local.subdomain}.jordibru.cloud"
  versioning     = var.bucket_versioning
  static_website = true
}

module "cloudfront" {
  source = "git@github.com:JordiiBru/aws-cloudfront.git?ref=v0.0.2"

  # Common variables
  stage   = var.stage
  owner   = var.owner
  purpose = var.purpose

  # Custom variables
  website_endpoint = module.s3_bucket.website_endpoint
  regional_domain  = module.s3_bucket.regional_domain
  cert_arn         = module.acm.certificate_arn
  subdomain        = local.subdomain
}

module "acm" {
  source = "git@github.com:JordiiBru/aws-acm.git?ref=v0.0.2"

  # Common variables
  stage   = var.stage
  owner   = var.owner
  purpose = var.purpose

  # Custom varibales
  subdomain = local.subdomain
}

module "r53" {
  source = "git@github.com:JordiiBru/aws-route53.git?ref=v0.0.2"

  # Common variables
  stage   = var.stage
  owner   = var.owner
  purpose = var.purpose

  # Custom variables
  subdomain = local.subdomain
  type      = "A"
  alias = {
    name    = module.cloudfront.distribution_domain_name[0]
    zone_id = module.cloudfront.distribution_zone_id[0]
  }
}