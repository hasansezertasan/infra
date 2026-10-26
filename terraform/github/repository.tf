# This repository's own settings. It carries the plan and apply workflows, so a destroy
# would remove the configuration itself; Terraform may never delete it.
#
# Only settings the read-only plan App can read are managed here. GitHub hides the merge
# settings (allow_*_merge, allow_auto_merge, allow_update_branch, delete_branch_on_merge and
# the merge commit title and message) from a token without write access, so managing them
# would make every plan show a change that is not real. See the "Repository merge settings"
# decision in README.md.
resource "github_repository" "infra" {
  name        = "infra"
  description = "@hasansezertasan loves IaC"
  visibility  = "public"

  has_issues      = true
  has_projects    = false
  has_wiki        = false
  has_discussions = false

  web_commit_signoff_required = false

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
