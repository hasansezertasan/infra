# Branch protection for the repository that holds this configuration. The plan and apply
# workflows live there, so its required check contexts are the job names they publish.
locals {
  protected_repository = "infra"
}

resource "github_branch_protection" "main" {
  repository_id = data.github_repository.managed[local.protected_repository].node_id
  pattern       = "main"

  allows_deletions    = false
  allows_force_pushes = false
  # Keep a break-glass path for the sole maintainer; applies are gated by the
  # production environment, not by this setting.
  enforce_admins = false

  required_status_checks {
    strict = true
    contexts = [
      "validate (cloudflare)",
      "validate (github)",
      # The aggregate check from terraform-plan.yml: it also covers every leaf plan.
      "plan",
    ]
  }

  required_pull_request_reviews {
    # A pull request is required; a sole maintainer cannot approve their own.
    required_approving_review_count = 0
  }
}
