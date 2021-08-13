param storageAccount string
param cdn string 

resource profile 'Microsoft.Cdn/profiles@2020-09-01' = {
  name: '${cdn}-profile'
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
  name: '${cdn}-endpoint'
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

// resource rules 'Microsoft.Cdn/profiles/ruleSets@2020-09-01' = {
//   parent: profile
//   name: 'rules'
// }

// resource dsa 'Microsoft.Cdn/profiles/ruleSets/rules@2020-09-01' = {
//   parent: rules
//   name: 'enforcehttps'
//   properties: {
//     order: 1
//     actions: [
//       {
//         name: 'UrlRedirect'
//         parameters: {
//           '@odata.type': '#Microsoft.Azure.Cdn.Models.DeliveryRuleUrlRedirectActionParameters'
//           destinationProtocol: 'Https'
//           redirectType: 'PermanentRedirect'
//         }
//       }
//     ]
//   }
// }
