provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "aks" {
  name     = "example-resources"
  location = "East US"
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "example-aks-cluster"
  location            = azurerm_resource_group.aks.location
  resource_group_name = azurerm_resource_group.aks.name
  dns_prefix          = "example-aks-cluster"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_B2s"
  }

  identity {
    type = "SystemAssigned"
  }
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.aks.kube_config_raw

  sensitive = true
}

