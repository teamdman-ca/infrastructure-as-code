Read-Config;

$params = Build-Params @{
    storageAccount = $storageAccount
};

az deployment group create `
    --name "site_storageAccount" `
    --resource-group $resourceGroup `
    --template-file "main.bicep" `
    --parameters $params;