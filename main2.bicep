param globalAdminObjectID string= '59539b13-818c-4fad-8129-2cb728bd4517'
param resourceGroupName string='denycheckrg'

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