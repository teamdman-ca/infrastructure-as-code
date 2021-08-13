resource dns 'Microsoft.Network/dnsZones@2018-05-01' = {
  location: resourceGroup().location
  name: 'teamdman.ca'
}
