import {
  to = namecheap_domain_records.main
  id = "teamdman.ca"
}

resource "namecheap_domain_records" "main" {
  domain     = "teamdman.ca"
  mode       = "OVERWRITE"
  email_type = "FWD"

  lifecycle {
    prevent_destroy = true
  }

  record {
    hostname = "@"
    type     = "A"
    address  = "185.199.109.153"
    ttl      = 60
  }

  record {
    hostname = "@"
    type     = "A"
    address  = "185.199.110.153"
    ttl      = 60
  }

  record {
    hostname = "@"
    type     = "A"
    address  = "185.199.111.153"
    ttl      = 60
  }

  record {
    hostname = "www"
    type     = "CNAME"
    address  = "teamdman-ca.github.io."
    ttl      = 60
  }

  record {
    hostname = "github-readme-stats"
    type     = "A"
    address  = data.azurerm_public_ip.traefik.ip_address
    ttl      = 60
  }

  record {
    hostname = "@"
    type     = "TXT"
    address  = "v=spf1 include:spf.efwd.registrar-servers.com ~all"
    ttl      = 1800
  }
}
