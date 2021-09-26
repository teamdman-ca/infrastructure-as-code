Read-Config;

$certId = az keyvault certificate show `
    --vault-name $keyVault `
    --name $certSecret `
    --query "id" `
    --output "tsv";

$params = Build-Params @{
    cdn            = $cdn
    storageAccount = $storageAccount
}

az deployment group create `
    --name "cdn" `
    --resource-group $resourceGroup `
    --template-file "main.bicep" `
    --parameters $params;