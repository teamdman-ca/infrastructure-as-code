param storageAccount string

resource sa 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: storageAccount
  location: resourceGroup().location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}
