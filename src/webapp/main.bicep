targetScope = 'subscription'

param appName string = 'demoApp'
param resourceGroupName string = 'tia-${uniqueString(appName)}-rg'

module rg '../../modules/arm/Microsoft.Resources/resourceGroups/deploy.bicep' = {
  name: 'rg-deploy'
  params: {
    name: resourceGroupName
  }
}

module app '../../solutions/tieredapp/deploy.bicep' = {
  scope: resourceGroup(resourceGroupName)
  name: 'tieredApp-deploy'
  params: {
    name: appName
    prefix: 'tia'
  }
}
