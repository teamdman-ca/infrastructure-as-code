# TeamDman Infrastructure as Code

[`.\init\`](.\init\) is used to provision the resource group and storage account to hold Terraform state files.

[`.\src\`](.\src\) is used to provision the cluster and:

- Cert manager
- Ingress controller
- nginx hello app