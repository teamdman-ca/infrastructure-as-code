Read-Config;

$cdnId = az cdn endpoint show `
    --resource-group $resourceGroup `
    --name $cdn `
    --profile-name $cdn `
    --query "id" `
    --output tsv;

Write-Host "Found cdn id=$cdnId";

az network dns record-set a create `
    --resource-group $resourceGroup `
    --zone-name $dns `
    --name '@' `
    --target-resource $cdnId `
    --ttl 30;