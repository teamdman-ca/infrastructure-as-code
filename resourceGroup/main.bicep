targetScope = 'subscription'

param location string

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'teamdman-ca'
  location: location
}
