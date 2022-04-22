Read-Config;

# $certId = az keyvault certificate show `
#     --vault-name $keyVault `
#     --name $certSecret `
#     --query "id" `
#     --output "tsv";

az cdn custom-domain enable-https `
    --resource-group $resourceGroup `
    --endpoint-name $endpointName `
    --profile-name $cdn `
    --name $hostNameLabel `
    --min-tls-version "1.2" `
    --user-cert-group-name $resourceGroup `
    --user-cert-vault-name $keyVault `
    --user-cert-secret-name $certSecret `
    --user-cert-protocol-type "sni";