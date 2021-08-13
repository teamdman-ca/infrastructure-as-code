$config = Get-Content .\config.json | ConvertFrom-Json;

az storage blob service-properties update `
    --account-name $config.storageAccount `
    --static-website `
    --404-document "404.html" `
    --index-document "index.html";