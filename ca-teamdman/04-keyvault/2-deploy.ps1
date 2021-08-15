Read-Config;

$myId = az ad signed-in-user show --query objectId --output tsv;

$cdnServicePrincipal = az ad sp show `
    --id $cdnAppId `
    --query "objectId" `
    --output tsv;

$params = Build-Params @{
    keyVault = $keyVault
    myUserObjectId = $myId
    cdnServicePrincipal = $cdnServicePrincipal
}

az deployment group create `
    --name "keyVault" `
    --resource-group $resourceGroup `
    --template-file "main.bicep" `
    --parameters $params;