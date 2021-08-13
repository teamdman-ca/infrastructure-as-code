$config = Get-Content .\config.json | ConvertFrom-Json;

$params = @{
    parameters =  @{
        storageAccount = @{
            value = $config.storageAccount;
        }
    }
} | ConvertTo-Json -Compress | ForEach-Object { $_ -replace '"', '\"' };

Write-Host "Deploying using params:`n$params";
az deployment group create `
    --name "site" `
    --resource-group $config.resourceGroup `
    --template-file "main.bicep" `
    --parameters $params;