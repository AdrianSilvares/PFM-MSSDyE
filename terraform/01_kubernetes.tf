resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.project_name}-aks"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  dns_prefix          = "${var.project_name}-aks"

  default_node_pool {
    name            = "default"
    vm_size         = "Standard_A2_v2"
    os_disk_size_gb = 30
    node_count      = 1
  }

  service_principal {
    client_id     = var.aks_service_principal_client_id
    client_secret = var.aks_service_principal_client_secret
  }

  tags = var.tags
}
