resource "cloudflare_dns_record" "dns_apex_cname" {
  comment = "CNAME record for hasansezertasan.com"
  content = "hasansezertasan.pages.dev"
  name    = "hasansezertasan.com"
  proxied = true
  tags    = []
  ttl     = 1
  type    = "CNAME"
  zone_id = local.infra_config.cloudflare_zone_id
  settings = {
    flatten_cname = false
  }
}

resource "cloudflare_dns_record" "dns_www_cname" {
  comment = "www CNAME record for hasansezertasan.com"
  content = "hasansezertasan.com"
  name    = "www.hasansezertasan.com"
  proxied = true
  tags    = []
  ttl     = 1
  type    = "CNAME"
  zone_id = local.infra_config.cloudflare_zone_id
  settings = {
    flatten_cname = false
  }
}

resource "cloudflare_dns_record" "dns_mx_route3" {
  content  = "route3.mx.cloudflare.net"
  name     = "hasansezertasan.com"
  priority = 75
  proxied  = false
  tags     = []
  ttl      = 1
  type     = "MX"
  zone_id  = local.infra_config.cloudflare_zone_id
  settings = {}
}

resource "cloudflare_dns_record" "dns_mx_route2" {
  content  = "route2.mx.cloudflare.net"
  name     = "hasansezertasan.com"
  priority = 43
  proxied  = false
  tags     = []
  ttl      = 1
  type     = "MX"
  zone_id  = local.infra_config.cloudflare_zone_id
  settings = {}
}

resource "cloudflare_dns_record" "dns_mx_route1" {
  content  = "route1.mx.cloudflare.net"
  name     = "hasansezertasan.com"
  priority = 77
  proxied  = false
  tags     = []
  ttl      = 1
  type     = "MX"
  zone_id  = local.infra_config.cloudflare_zone_id
  settings = {}
}

resource "cloudflare_dns_record" "dns_dkim_cf2024_1" {
  content  = "\"v=DKIM1; h=sha256; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAiweykoi+o48IOGuP7GR3X0MOExCUDY/BCRHoWBnh3rChl7WhdyCxW3jgq1daEjPPqoi7sJvdg5hEQVsgVRQP4DcnQDVjGMbASQtrY4WmB1VebF+RPJB2ECPsEDTpeiI5ZyUAwJaVX7r6bznU67g7LvFq35yIo4sdlmtZGV+i0H4cpYH9+3JJ78k\" \"m4KXwaf9xUJCWF6nxeD+qG6Fyruw1Qlbds2r85U9dkNDVAS3gioCvELryh1TxKGiVTkg4wqHTyHfWsp7KD3WQHYJn0RyfJJu6YEmL77zonn7p2SRMvTMP3ZEXibnC9gz3nnhR6wcYL8Q7zXypKTMD58bTixDSJwIDAQAB\""
  name     = "cf2024-1._domainkey.hasansezertasan.com"
  proxied  = false
  tags     = []
  ttl      = 1
  type     = "TXT"
  zone_id  = local.infra_config.cloudflare_zone_id
  settings = {}
}

resource "cloudflare_dns_record" "dns_dmarc" {
  comment  = "DMARC record for hasansezertasan.com"
  content  = "\"v=DMARC1; p=none; rua=mailto:${local.infra_config.cloudflare_dmarc_report_id}@dmarc-reports.cloudflare.net\""
  name     = "_dmarc.hasansezertasan.com"
  proxied  = false
  tags     = []
  ttl      = 1
  type     = "TXT"
  zone_id  = local.infra_config.cloudflare_zone_id
  settings = {}
}

resource "cloudflare_dns_record" "dns_spf" {
  comment  = "TXT record for SPF"
  content  = "\"v=spf1 include:_spf.mx.cloudflare.net ~all\""
  name     = "hasansezertasan.com"
  proxied  = false
  tags     = []
  ttl      = 1
  type     = "TXT"
  zone_id  = local.infra_config.cloudflare_zone_id
  settings = {}
}
