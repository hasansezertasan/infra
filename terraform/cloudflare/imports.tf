import {
  to = cloudflare_dns_record.dns_apex_cname
  id = "${local.infra_config.cloudflare_zone_id}/${local.infra_config.cloudflare_import_ids.dns_apex_cname}"
}

import {
  to = cloudflare_dns_record.dns_www_cname
  id = "${local.infra_config.cloudflare_zone_id}/${local.infra_config.cloudflare_import_ids.dns_www_cname}"
}

import {
  to = cloudflare_dns_record.dns_mx_route3
  id = "${local.infra_config.cloudflare_zone_id}/${local.infra_config.cloudflare_import_ids.dns_mx_route3}"
}

import {
  to = cloudflare_dns_record.dns_mx_route2
  id = "${local.infra_config.cloudflare_zone_id}/${local.infra_config.cloudflare_import_ids.dns_mx_route2}"
}

import {
  to = cloudflare_dns_record.dns_mx_route1
  id = "${local.infra_config.cloudflare_zone_id}/${local.infra_config.cloudflare_import_ids.dns_mx_route1}"
}

import {
  to = cloudflare_dns_record.dns_dkim_cf2024_1
  id = "${local.infra_config.cloudflare_zone_id}/${local.infra_config.cloudflare_import_ids.dns_dkim_cf2024_1}"
}

import {
  to = cloudflare_dns_record.dns_dmarc
  id = "${local.infra_config.cloudflare_zone_id}/${local.infra_config.cloudflare_import_ids.dns_dmarc}"
}

import {
  to = cloudflare_dns_record.dns_spf
  id = "${local.infra_config.cloudflare_zone_id}/${local.infra_config.cloudflare_import_ids.dns_spf}"
}

import {
  to = cloudflare_r2_bucket.infra_state
  id = "${local.infra_config.cloudflare_account_id}/hasansezertasan-infra-state/default"
}
