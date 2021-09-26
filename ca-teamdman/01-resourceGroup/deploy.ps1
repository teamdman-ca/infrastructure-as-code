Read-Config;
$params = Build-Params @{
    location = $location
    name = $resourceGroup
};

az deployment sub create `
    --name "ca.raddest" `
    --template-file "main.bicep" `
    --location $location `
    --parameters $params;