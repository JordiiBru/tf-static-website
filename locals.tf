locals {
  domain_name       = "jordibru.cloud"
  final_domain_name = var.stage == "prod" ? "${var.purpose}.${local.domain_name}" : "${var.stage}-${var.purpose}.${local.domain_name}"
}