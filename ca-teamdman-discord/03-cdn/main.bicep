param storageAccountResourceGroup string
param storageAccount string
param cdnName string 
param endpointName string

// Discover existing profile
resource profile 'Microsoft.Cdn/profiles@2020-09-01' existing = {
  name: cdnName
}

// Discover existing storage account in other resource group
resource site 'Microsoft.Storage/storageAccounts@2021-04-01' existing = {
  name: storageAccount
  scope: resourceGroup(storageAccountResourceGroup)
}

// Obtain origin for storage account
var origin = replace(replace(site.properties.primaryEndpoints.web,'https://',''), '/', '')

// Create endpoint for storage account
resource endpoint 'Microsoft.Cdn/profiles/endpoints@2020-09-01' = {
  parent: profile
  name: endpointName
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
