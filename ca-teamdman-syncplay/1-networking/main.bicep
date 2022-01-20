param location string = 'eastus'

resource vnet 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: 'syncplay'
  location: location
  properties: {
    addressSpace: {
       addressPrefixes: [
          '10.0.0.0/16'
       ]
    }
  }
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2021-05-01' = {
  parent: vnet
  name: 'default'
  properties: {
    addressPrefix: '10.0.0.0/24'
  }
}

resource nsg 'Microsoft.Network/networkSecurityGroups@2021-05-01' = {
  name: 'syncplay'
  location: location
}

resource ip 'Microsoft.Network/publicIpAddresses@2019-02-01' = {
  name: 'syncplay'
  location: location
  properties: {
    publicIPAllocationMethod: 'Dynamic'
  }
  sku: {
    name: 'Basic'
  }
}

resource nic 'Microsoft.Network/networkInterfaces@2021-03-01' = {
  name: 'syncplay'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: subnet.id
          }
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: ip.id
          }
        }
      }
    ]
    networkSecurityGroup: {
      id: nsg.id
    }
  }
}
