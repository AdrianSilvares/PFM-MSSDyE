// VARIABLES GENERALES

subscription_id = ""
tenant_id       = ""
rg              = ""
location        = "northeurope"
azurerm_version = "=1.44.0"
project_name    = "tfm"
email           = ["adrian.silvares.ramos@alumnos.upm.es"]
password        = ""

tags = {
  terraform   = "true"
  proyecto    = "Despliegue continuo y orquestacion de microservicios contenerizados para IoT"
  universidad = "UPM"
  escuela     = "ETSISI"
  alumno      = "Adrian Silvares"
}

// VARIABLES AKS

agent_count                         = "2"
aks_service_principal_client_id     = ""
aks_service_principal_client_secret = ""

// VARIABLES STORAGE

storageaccount           = "storageaccountmsdetfm"
storageaccount_container = "terraform"
storagekey               = "terraform.tfstate"

// VARIABLES VIRTUAL MACHINE

iot_edge_ubuntu = {
  offer     = "iot_edge_vm_ubuntu"
  publisher = "microsoft_iot_edge"
  sku       = "ubuntu_1604_edgeruntimeonly"
  urn       = "microsoft_iot_edge:iot_edge_vm_ubuntu:ubuntu_1604_edgeruntimeonly:latest"
  version   = "latest"
}
