# This repository's own settings. It carries the plan and apply workflows, so a destroy
# would remove the configuration itself; Terraform may never delete it.
resource "github_repository" "infra" {
  name        = "infra"
  description = "@hasansezertasan loves IaC"
  visibility  = "public"

  has_issues      = true
  has_projects    = false
  has_wiki        = false
  has_discussions = false

  allow_merge_commit     = false
  allow_rebase_merge     = false
  allow_squash_merge     = true
  allow_auto_merge       = true
  allow_update_branch    = true
  delete_branch_on_merge = true

  squash_merge_commit_title   = "PR_TITLE"
  squash_merge_commit_message = "BLANK"

  web_commit_signoff_required = false
  archive_on_destroy          = true

  security_and_analysis {
    secret_scanning {
      status = "enabled"
    }
    secret_scanning_push_protection {
      status = "enabled"
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}

import {
  to = github_repository.infra
  id = "infra"
}
