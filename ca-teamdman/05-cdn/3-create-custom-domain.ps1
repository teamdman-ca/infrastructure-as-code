Read-Config;

az cdn custom-domain create `
    --resource-group $resourceGroup `
    --endpoint-name $cdn `
    --profile-name $cdn `
    --name $hostNameLabel `
    --hostname $hostName;

az cdn custom-domain enable-https `
    --resource-group $resourceGroup `
    --endpoint-name $cdn `
    --profile-name $cdn `
    --name $hostNameLabel `
    --min-tls-version "1.2" `
    --user-cert-group-name $resourceGroup `
    --user-cert-vault-name $keyVault `
    --user-cert-secret-name $certSecret `
    --user-cert-protocol-type "sni";