module "s3_bucket" {
  source = "../"

  # Required variables
  stage   = "test"
  owner   = "wanda"
  purpose = "tfg"

  # Optional variables
}