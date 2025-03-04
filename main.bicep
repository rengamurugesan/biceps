resource denySetting 'Microsoft.Resources/denyAssignments@2021-04-01' = {
  name: 'denyDelete'
  properties: {
    denyAssignmentName: 'denyDelete'
    scope: resourceGroup()
    principalId: subscription().tenantId
    permissions: [
      {
        actions: []
        notActions: [
          'Microsoft.Storage/storageAccounts/delete',
          'Microsoft.Network/virtualNetworks/delete'
        ]
        dataActions: []
        notDataActions: []
      }
    ]
    doNotApplyToChildScopes: true
    excludePrincipals: []
    isSystemAssigned: true
  }
}