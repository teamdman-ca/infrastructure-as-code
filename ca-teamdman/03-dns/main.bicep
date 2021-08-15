param hostname string

resource dns 'Microsoft.Network/dnsZones@2018-05-01' = {
  location: 'global'
  name: hostname
}

var verifyRecords = [
  {
    name: 'awverify'
    value: 'awverify.${hostname}.azurewebsies.net'
  }
  {
    name: 'wwww'
    value: '${hostname}.azurewebsites.net'
  }
  {
    name: 'awverify.www'
    value: 'awverify.${hostname}.azurewebsiets.net'
  }
]
  

resource awverify 'Microsoft.Network/dnsZones/CNAME@2018-05-01' = [for record in verifyRecords: {
  parent: dns
  name: record.name
  properties: {
    TTL: 30
    CNAMERecord: {
      cname: record.value
    }
  }
}]
