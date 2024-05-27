module "static" {
  source = "../"

  # Required variables
  stage   = "dev"
  owner   = "wanda"
  purpose = "portfolio"

  # Custom variables
  bucket_versioning = true
}