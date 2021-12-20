targetScope = 'subscription'

param subscriptionId string
param resourceGroupName string = 'demo-${uniqueString(subscriptionId)}-rg'

module rg '../../modules/arm/Microsoft.Resources/resourceGroups/deploy.bicep' = {
  name: 'rg-deploy'
  params: {
    name: resourceGroupName
  }
}