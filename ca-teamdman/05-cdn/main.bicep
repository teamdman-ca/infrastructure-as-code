param storageAccount string
param cdn string 

resource profile 'Microsoft.Cdn/profiles@2020-09-01' = {
  name: cdn
  location: resourceGroup().location
  sku: {
    name: 'Standard_Microsoft'
  }
}

resource site 'Microsoft.Storage/storageAccounts@2021-04-01' existing = {
  name: storageAccount
}

var origin = replace(replace(site.properties.primaryEndpoints.web,'https://',''), '/', '')

resource endpoint 'Microsoft.Cdn/profiles/endpoints@2020-09-01' = {
  parent: profile
  name: cdn
  location: resourceGroup().location
  properties: {
    originHostHeader: origin
    isHttpAllowed: true
    isHttpsAllowed: true
    queryStringCachingBehavior: 'IgnoreQueryString'
    contentTypesToCompress: [
      'text/plain'
      'text/html'
      'text/css'
      'application/x-javascript'
      'text/javascript'
    ]
    isCompressionEnabled: true
    origins: [
      {
        name: 'origin1'
        properties: {
          hostName: origin
        }
      }
    ]
  }
}
