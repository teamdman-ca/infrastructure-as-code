Read-Config;
$params = Build-Params @{
    hostname=$hostname
};

az deployment group create `
    --name "dns" `
    --resource-group $resourceGroup `
    --template-file "main.bicep" `
    --parameters $params;