param resourceGroupName string= 'denycheckrg'
param location string = resourceGroup().location
param globalAdminObjectID string= '59539b13-818c-4fad-8129-2cb728bd4517'
resource deploymentstack 'Microsoft.Resources/deploymentStacks@2022-08-01-preview' ={
  name: 'mydeploymentstack'  
  properties: {
    description: 'Deployment stack for managing resources'
    actionOnUnmanage: { 
	 resourceGroups: 'detach'
         resources: 'detach'
    }
    denySettings: {
      mode: 'denyWriteAndDelete'
      excludedActions: []   
      excludedPrincipals: [
          globalAdminObjectID
      ]
    }
    template: {
      schema: 'https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#'
      contentVersion: '1.0.0.0'
      resources: []
    }
  }
}

resource denySetting 'Microsoft.Authorization/denyAssignments@2024-07-01-preview' = {
  name: guid(resourceGroup().id, 'denyAssignmentName')  
  properties: {
    denyAssignmentName: 'test-stack'   
    scope: resourceId('Microsoft.Resources/resourceGroups', resourceGroupName)
    permissions: [
      {
        actions: [
          '*/write'
        ]
        notActions: []
        dataActions: []
        notDataActions: []
      }
    ]
    principals:[
      {
        id: globalAdminObjectID
        type: 'User'
      }           
    ]    
    doNotApplyToChildScopes: true
    excludePrincipals: []
    isSystemAssigned: true
  }
}
