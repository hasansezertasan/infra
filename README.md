# Infrastructure

Terraform-managed Cloudflare and GitHub infrastructure for `hasansezertasan` (state in s3 object storage, CI in GitHub Actions), generated
from [copier-infra](https://github.com/hasansezertasan/copier-infra) and designed to be
maintained with [infra-skills](https://github.com/hasansezertasan/infra-skills).

## Start here

1. Install infra-skills using its current installation instructions.
2. Ask your agent to use infra-skills to finish setup (the state bucket, plan and apply workflows, GitHub Apps and the `production` environment).
3. Pull template changes later with `uvx copier update`.

Do not commit credentials. Public deployment identifiers live in the [Config](#config)
block below, rendered from `.copier-answers.yml`; API tokens and GitHub App
credentials belong only in GitHub Actions secrets, with apply credentials only in the `production` environment.

## Shape

Each directory below is an independent Terraform root with its own state and provider
lock file:

| Directory | State prefix | Initial responsibility |
|---|---|---|
| `terraform/cloudflare` | `terraform/state/cloudflare` | Verify access to the configured Cloudflare zone |
| `terraform/github` | `terraform/state/github` | Verify access to the configured GitHub repositories |

The initial data sources are read-only credential probes. Add managed resources with
infra-skills after setup. If a resource already exists, import it before applying.

## Config

Public deployment identifiers, never credentials. Rendered by copier from the answers in
`.copier-answers.yml`: change an answer with `uvx copier update` and review the diff, not
by hand, so the Terraform backend blocks stay aligned. Only the region between the
`infra:customization` comments is written by infra-skills and by you (GitHub App data,
state-transfer evidence, additional providers and attestation timestamps); a
Template update keeps it and rewrites the rest. Keep both comments.

<!-- infra:config start -->
```yaml
backend: object-storage
github_org: "hasansezertasan"
apex_domain: "hasansezertasan.com"
cloudflare_account_id: "d8a72309e747515805b614574ea7f323"
cloudflare_zone_id: "94004cdc8f054251dc4543a35175ee4a"
managed_repos:
  - "hasansezertasan/infra"
state_backend: s3
state_bucket: "hasansezertasan-infra-state"
state_prefix: "terraform/state"
state_endpoint: "https://d8a72309e747515805b614574ea7f323.r2.cloudflarestorage.com"
state_lock_table: ""
state_region: "auto"
# infra:customization start
leaf_backends: {}
state_transfers: {}
github_apps:
  plan_app_id: ""
  apply_app_id: ""
  reviewed_at: ""
  plan_manifest_blob: ""
  apply_manifest_blob: ""
additional_providers: []
# infra:customization end
```
<!-- infra:config end -->

## Decisions

Durable provider, authentication, state, and safety choices for this repository. Statuses
are `proposed`, `locked`, or `superseded`. Record changed decisions here rather than
silently replacing their history, and never add tokens, private keys, or credentials.

<!-- infra:decisions start -->

| Decision | Choice | Status | Rationale |
|---|---|---|---|
| Terraform backend | s3 object storage with GitHub Actions CI | locked | State in a private versioned bucket; plans appear in pull requests |
| State boundaries | One state prefix per provider leaf | locked | Limits credentials and blast radius by concern |
| Toolchain | Exact pins in `mise.toml` and committed `mise.lock` | locked | Keeps local, CI, and Terraform versions aligned |
| GitHub authentication | GitHub App | locked | Avoids credentials tied to an individual user |
| Secret storage | GitHub Actions secrets; apply credentials only in the `production` environment | locked | Keeps write access to `main`-only jobs |
| Apply policy | `production` environment on `main` with required reviewers | locked | Preserves a human review gate for infrastructure changes |
| State history | no-versioning | locked | Cloudflare R2 does not implement bucket versioning, so a bad apply cannot be rolled back from the bucket; accepted because this state holds only Cloudflare and GitHub resources |

<!-- infra:decisions end -->

## Development

Review `mise.toml` before trusting it, then install the committed toolchain:

```sh
mise trust mise.toml
MISE_LOCKED=1 mise install terraform gh jq
mise exec -- make check
```

`ci.yml` runs credential-free formatting, validation, and contract checks. The plan and
apply workflows are added by infra-setup; applies run from `main` in the
`production` environment.
