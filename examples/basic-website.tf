module "static" {
  source = "../"

  # Required variables
  stage   = "dev"
  owner   = "wanda"
  purpose = "portfolio"

  # Optional variables
  bucket_versioning = true
}