Read-Config;

az cdn custom-domain create `
    --resource-group $resourceGroup `
    --endpoint-name $endpointName `
    --profile-name $cdn `
    --name $hostNameLabel `
    --hostname $hostName;
