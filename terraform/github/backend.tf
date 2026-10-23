terraform {
  backend "s3" {
    bucket = "hasansezertasan-infra-state"
    key    = "terraform/state/github/terraform.tfstate"
    region = "auto"

    endpoints = {
      s3 = "https://d8a72309e747515805b614574ea7f323.r2.cloudflarestorage.com"
    }
    use_lockfile                = true
    use_path_style              = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }
}
