// VARIABLES GENERALES

variable "subscription_id" {
  type = string
}

variable "tenant_id" {
  type = string
}

variable "rg" {
  type = string
}

variable "location" {
  type = string
}

variable "azurerm_version" {
  type = "string"
}

variable "project_name" {
  type = "string"
}

variable "tags" {
  type = "map"
}

variable "email" {
  type = list
}

variable "password" {
  type = string
}


// VARIABLES AKS

variable "agent_count" {
  type = string
}

variable "aks_service_principal_client_id" {
  type = string
}

variable "aks_service_principal_client_secret" {
  type = string
}

// VARIABLES STORAGE ACCOUNT

variable "storageaccount" {
  type = string
}

variable "storageaccount_container" {
  type = string
}

variable "storagekey" {
  type = string
}

// VARIABLES VIRTUAL MACHINE

variable "iot_edge_ubuntu" {
  type = map
}
