param resourceGroupName string='denycheckrg'
param resourceGroupLocation string = resourceGroup().location

resource deploymentStack 'Microsoft.Resources/deploymentStacks@2020-04-01-preview' = {
  name: 'securityDeploymentStack'
  location: resourceGroupLocation
  properties: {
    actionOnUnmanage: 'detach'
    denySettingsMode: 'denyDelete'
    template: {
      $schema: 'https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#'
      contentVersion: '1.0.0.0'
      resources: []
    }
  }
}

resource denySetting 'Microsoft.Authorization/denyAssignments@2020-04-01-preview' = {
  name: 'denyDelete'
  properties: {
    denyAssignmentName: 'denyDelete'
    scope: resourceId('Microsoft.Resources/resourceGroups', resourceGroupName)
    permissions: [
      {
        actions: []
        notActions: [
          'Microsoft.Resources/subscriptions/resourceGroups/delete',
          'Microsoft.Storage/storageAccounts/delete',
          'Microsoft.Network/virtualNetworks/delete'
        ]
        dataActions: []
        notDataActions: []
      }
    ]
    principalId: subscription().tenantId
    doNotApplyToChildScopes: true
    excludePrincipals: []
    isSystemAssigned: true
  }
}
