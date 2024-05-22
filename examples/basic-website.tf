module "static" {
  source = "../"

  # Required variables
  stage   = "test"
  owner   = "wanda"
  purpose = "tfg"

  # Optional variables
  domain_name       = "jordibru.cloud"
  bucket_versioning = true
  record_nameservers = [
    "ns-1583.awsdns-05.co.uk.",
    "ns-81.awsdns-10.com.",
    "ns-542.awsdns-03.net.",
    "ns-1515.awsdns-61.org."
  ]
  static_website = true
}