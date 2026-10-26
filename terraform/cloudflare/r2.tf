# The state bucket holds this repository's own Terraform state; never let a plan destroy it.
resource "cloudflare_r2_bucket" "infra_state" {
  account_id = local.infra_config.cloudflare_account_id
  name       = "hasansezertasan-infra-state"

  lifecycle {
    prevent_destroy = true
  }
}
