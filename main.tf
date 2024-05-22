locals {
  final_domain_name = "${var.stage}.${var.domain_name}"
}

module "s3_bucket" {
  source = "git@github.com:JordiiBru/aws-s3-bucket.git"

  # Required variables
  stage   = var.stage
  owner   = var.owner
  purpose = var.purpose

  # Optional variables
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

  # Optional variables
  bucket_origin_id = module.s3_bucket.base_domain
  regional_domain  = module.s3_bucket.regional_domain
  cert_id          = module.acm.certificate_arn[0]
}

module "acm" {
  source = "git@github.com:JordiiBru/aws-acm.git"

  # Required variables
  stage       = var.stage
  owner       = var.owner
  purpose     = var.purpose
  domain_name = local.final_domain_name
}

module "r53" {
  source = "git@github.com:JordiiBru/aws-route53.git"

  # Required variables
  stage   = var.stage
  owner   = var.owner
  purpose = var.purpose
  domain_name = local.final_domain_name

  # Optional variables
  cloudfront_endpoint = module.cloudfront.cf_domain_name[0]
  cloudfront_zone_id  = module.cloudfront.cf_zone_id[0]
  nameservers         = var.record_nameservers

}