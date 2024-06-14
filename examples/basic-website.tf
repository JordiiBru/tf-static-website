module "static" {
  source = "../"

  # Common variables
  stage   = "dev"
  owner   = "wanda"
  purpose = "tfg"

  # Custom variables
  bucket_versioning = true
}