Read-Config;

$certId = az keyvault certificate show `
    --vault-name $keyVault `
    --name $certSecret `
    --query "id" `
    --output "tsv";

$params = Build-Params @{
    storageAccount = $storageAccount
    cdn            = $cdn
    hostName       = $hostName
    hostNameLabel  = $hostNameLabel
    certId         = $certId
    dns            = $dns
}

az deployment group create `
    --name "cdn" `
    --resource-group $resourceGroup `
    --template-file "main.bicep" `
    --parameters $params;