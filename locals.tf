locals {
  subdomain = var.stage == "prod" ? "${var.purpose}" : "${var.stage}-${var.purpose}"
}