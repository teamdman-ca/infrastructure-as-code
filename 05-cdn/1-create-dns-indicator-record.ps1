Write-Error @"
Az cli missing support for this.
Use the azure portal to create the A record alias to the CDN profile instead.
"@
return;

Read-Config;

$cdnId = az cdn endpoint show `
    --resource-group $resourceGroup `
    --name $cdn `
    --profile-name $cdn `
    --query "id" `
    --output tsv;

Write-Host "Found cdn id=$cdnId";

az network dns record-set a add-record `
    --resource-group $resourceGroup `
    --zone-name $dns `
    --record-set-name "@" `
    --ipv4-address $cdnId `
    --if-none-match `
    --ttl 30 `
# --target-resource $cdnId `
