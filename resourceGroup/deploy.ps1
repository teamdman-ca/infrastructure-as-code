az account set --subscription $env:subscription;

$config = Get-Content .\config.json | ConvertFrom-Json;

$params = @{
    parameters =  @{
        location = @{
            value = $config.location;
        }
    }
} | ConvertTo-Json -Compress | ForEach-Object { $_ -replace '"', '\"' };

Write-Host "Deploying using params:`n$params";
az deployment sub create `
    --name "teamdman-ca-resourcegroup" `
    --template-file "main.bicep" `
    --location $config.location `
    --parameters $params;