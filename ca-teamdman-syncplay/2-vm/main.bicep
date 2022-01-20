param location string = 'eastus'

resource nic 'Microsoft.Network/networkInterfaces@2021-03-01' existing = {
  name: 'syncplay'
}

resource sshKey 'Microsoft.Compute/sshPublicKeys@2021-07-01' existing = {
  name: 'dominic-desktop-id_rsa'
  scope: resourceGroup('ca.teamdman')
}

resource vm 'Microsoft.Compute/virtualMachines@2021-07-01' = {
  name: 'syncplay'
  location: location
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_B1s'
    }
    storageProfile: {
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'Standard_LRS'
        }
      }
      imageReference: {
        publisher: 'canonical'
        offer: '0001-com-ubuntu-server-focal'
        sku: '20_04-lts-gen2'
        version: 'latest'
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nic.id
        }
      ]
    }
    osProfile: {
      computerName: 'syncplay'
      adminUsername: 'azureuser'
      linuxConfiguration: {
        disablePasswordAuthentication: true
        ssh: {
          publicKeys: [
            {
              path: '/home/azureuser/.ssh/authorized_keys'
              keyData: sshKey.properties.publicKey
            }
          ]
        }
      }
    }
  }
}
