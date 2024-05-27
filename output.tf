# More on: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#attribute-reference
output "bucket_name" {
  description = "The name of the S3 bucket hosting the static website."
  value       = module.s3_bucket.bucket_name
}

output "bucket_arn" {
  description = "The ARN of the S3 bucket hosting the static website."
  value       = module.s3_bucket.bucket_arn
}

output "cloudfront_distribution_arn" {
  description = "The ARN of the CloudFront distribution."
  value       = module.cloudfront.cf_distr_arn
}

output "cloudfront_domain_name" {
  description = "The domain name of the CloudFront distribution."
  value       = module.cloudfront.cf_domain_name
}

output "cloudfront_zone_id" {
  description = "The hosted zone ID of the CloudFront distribution."
  value       = module.cloudfront.cf_zone_id
}

output "acm_certificate_arn" {
  description = "The ARN of the ACM certificate used for the CloudFront distribution."
  value       = module.acm.certificate_arn
}

output "route53_zone_name" {
  description = "The name of the Route 53 hosted zone."
  value       = module.r53.zone_name
}

output "route53_zone_id" {
  description = "The ID of the Route 53 hosted zone."
  value       = module.r53.zone_id
}

output "route53_record_name" {
  description = "The name of the Route 53 record for the CloudFront distribution."
  value       = module.r53.record_name
}