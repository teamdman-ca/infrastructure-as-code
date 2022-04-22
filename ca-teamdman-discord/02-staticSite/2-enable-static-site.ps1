Read-Config;

az storage blob service-properties update `
    --account-name $storageAccount `
    --static-website `
    --404-document "404.html" `
    --index-document "index.html";