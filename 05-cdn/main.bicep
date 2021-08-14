param storageAccount string
param cdn string 
param dns string
param hostName string
param hostNameLabel string
param certId string

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

resource zone 'Microsoft.Network/dnsZones@2018-05-01' existing = {
  name: dns
}

resource domain 'Microsoft.Cdn/profiles/customDomains@2020-09-01' = {
  parent: profile
  name: hostNameLabel
  properties: {
    hostName: hostName
    azureDnsZone: {
      id: zone.id
    }
    tlsSettings: {
      certificateType: 'CustomerCertificate'
      minimumTlsVersion: 'TLS12'
      secret: {
        id: certId
      }
    }
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
