$config = Get-Content .\config.json | ConvertFrom-Json;

$params = @{
    parameters =  @{
        storageAccount = @{
            value = $config.storageAccount
        }
        cdn = @{
            value = $config.cdn
        }
    }
} | ConvertTo-Json -Compress | ForEach-Object { $_ -replace '"', '\"' };

Write-Host "Deploying using params:`n$params";
az deployment group create `
    --name "cdn" `
    --resource-group $config.resourceGroup `
    --template-file "main.bicep" `
    --parameters $params;