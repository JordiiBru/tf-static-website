locals {
  domain_name       = "jordibru.cloud"
  final_domain_name = var.stage == "prod" ? "${var.purpose}.${local.domain_name}" : "${var.stage}-${var.purpose}.${local.domain_name}"
}

module "s3_bucket" {
  source = "git@github.com:JordiiBru/aws-s3-bucket.git"

  # Required variables
  stage   = var.stage
  owner   = var.owner
  purpose = var.purpose

  # Custom variables
  force_name     = local.final_domain_name
  versioning     = var.bucket_versioning
  static_website = var.static_website
}

module "cloudfront" {
  source = "git@github.com:JordiiBru/aws-cloudfront.git"

  # Required variables
  stage   = var.stage
  owner   = var.owner
  purpose = var.purpose

  # Custom variables
  bucket_origin_id = module.s3_bucket.base_domain
  website_endpoint = module.s3_bucket.website_endpoint
  regional_domain  = module.s3_bucket.regional_domain
  cert_id          = module.acm.certificate_arn
  domain_name      = local.final_domain_name
}

module "acm" {
  source = "git@github.com:JordiiBru/aws-acm.git?ref=v0.0.1"

  # Required variables
  stage   = var.stage
  owner   = var.owner
  purpose = var.purpose

  # Custom varibales
  domain_name = local.final_domain_name
}

module "r53" {
  source = "git@github.com:JordiiBru/aws-route53.git?ref=v0.0.1"

  # Required variables
  stage   = var.stage
  owner   = var.owner
  purpose = var.purpose

  # Custom variables
  domain_name               = local.final_domain_name
  cloudfront_endpoint       = module.cloudfront.cf_domain_name[0]
  cloudfront_zone_id        = module.cloudfront.cf_zone_id[0]
  domain_validation_options = module.acm.domain_validation_options[0]
}