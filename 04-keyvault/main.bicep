param keyVault string
param myUserObjectId string
param cdnServicePrincipal string

resource vault 'Microsoft.KeyVault/vaults@2021-06-01-preview' = {
  name: keyVault
  location: resourceGroup().location
  properties: {
    sku: {
      name: 'standard'
      family: 'A'
    }
    tenantId: subscription().tenantId
    accessPolicies: [
      {
        objectId: myUserObjectId
        tenantId: subscription().tenantId
        permissions: {
          certificates: [
            'all'
          ]
          secrets: [
            'all'
          ]
          keys: [
            'all'
          ]
          storage: [
            'all'
          ]
        }
      }
      {
        objectId: cdnServicePrincipal
        tenantId: subscription().tenantId
        permissions: {
          certificates: [ 
            'get'
            'list'
          ]
          secrets: [
            'get'
            'list'
          ]
        }
      }
    ]
    publicNetworkAccess: 'enabled'
    
  }
}
