# Create a resource group

resource "azurerm_resource_group" "k8s" {
  name     = var.rg_name
  location = var.location
}


# Create container registry

resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.k8s.name
  location            = azurerm_resource_group.k8s.location
  sku                 = "Basic"
  admin_enabled       = true
}

# Create AKS cluster

resource "azurerm_kubernetes_cluster" "k8s" {
  name                = var.cluster_name
  location            = azurerm_resource_group.k8s.location
  resource_group_name = azurerm_resource_group.k8s.name
  # dns_prefix          = var.dns_prefix
  dns_prefix          = "weightdns"

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name       = "agentpool"
    node_count = var.agent_count
    # node_count = 1
    vm_size    = "Standard_B2s"
    # vm_size    = "Standard_B2ms"

  }

  network_profile {
    load_balancer_sku = "standard"
    network_plugin    = "kubenet"
  }

  tags = {
    Environment = "${var.TF_VAR_enviroment}"
  }
}