# TeamDman infrastructure as code

The [Namecheap root](namecheap/) manages `teamdman.ca` DNS. It uses the `statefiles` container in the `personalcorestatefile` storage account with the key `dns/teamdman.ca/namecheap.tfstate`. The previous Azure roots and earlier experiments live in [old/](old/). `teamy-azure-iac` manages the replacement Azure infrastructure.

## DNS adoption and Stats cutover

1. Deploy the Stats ingress and production ACME issuer in `teamy-azure-iac` so Traefik can route the hostname and serve the certificate challenge.
2. Sign in to Azure CLI with access to read public IPs in `Personal.Core.AKS.Nodes.RG`. Supply `NAMECHEAP_API_USER`, `NAMECHEAP_API_KEY`, and `NAMECHEAP_USER_NAME` in the process environment and run from an IPv4 address enabled for Namecheap API access.
3. Run `tofu init -reconfigure` from `namecheap/`. With Azure CLI authentication, OpenTofu needs a single account selector. This root uses `tenant_id`.
4. Review the Terraform plan. The import block adopts `teamdman.ca`. `OVERWRITE` sends the complete host record set, so the only expected record change is the Stats A record moving to the Azure public IP tagged `k8s-azure-service=traefik/traefik`. Keep the observed three GitHub Pages apex records, the `www` CNAME, and the mail forwarding SPF record. The `FWD` mail setting supplies Namecheap's forwarding MX records.
5. After cutover, check the public Stats SVG over HTTPS and verify the apex, `www`, MX, and SPF answers against the pre-cutover records.
