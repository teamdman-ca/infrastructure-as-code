Read-Config;

$params = Build-Params @{
    storageAccountResourceGroup = $storageAccountResourceGroup
    endpointName                = $endpointName
    storageAccount              = $storageAccount
    cdnName                     = $cdn
}

az deployment group create `
    --name "cdn" `
    --resource-group $resourceGroup `
    --template-file "main.bicep" `
    --parameters $params;