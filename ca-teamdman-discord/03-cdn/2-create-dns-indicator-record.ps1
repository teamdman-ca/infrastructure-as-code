Read-Config;

$cdn = az cdn endpoint show `
    --resource-group $resourceGroup `
    --name $endpointName `
    --profile-name $cdn `
    --output json `
| ConvertFrom-Json;

az network dns record-set cname set-record `
    --resource-group $resourceGroup `
    --zone-name $dns `
    --record-set-name $subdomain `
    --cname $cdn.hostName `
    --if-none-match `
    --ttl 30;
