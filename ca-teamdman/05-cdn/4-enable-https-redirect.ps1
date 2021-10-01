Read-Config;

az cdn endpoint rule add `
    --resource-group $resourceGroup `
    --profile-name $cdn `
    --name $cdn `
    --order 1 `
    --rule-name "http_to_https" `
    --match-variable "RequestScheme" `
    --operator "Equal" `
    --match-values "HTTP" `
    --action-name "UrlRedirect" `
    --redirect-protocol "Https" `
    --redirect-type "PermanentRedirect";