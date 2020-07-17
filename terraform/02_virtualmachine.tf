resource "azurerm_virtual_network" "vnet" {
  name                = "${var.project_name}-network"
  address_space       = ["10.0.0.0/16"]
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "internal"
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix       = "10.0.2.0/24"
}

resource "azurerm_network_interface" "nic_1" {
  name                = "${var.project_name}-nic-1"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "configuration"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.ioetdge_ip_1.id
  }
}

resource "azurerm_virtual_machine" "ioetdge_vm_1" {
  name                             = "${var.project_name}-iotedge-vm-1"
  location                         = data.azurerm_resource_group.rg.location
  resource_group_name              = data.azurerm_resource_group.rg.name
  network_interface_ids            = [azurerm_network_interface.nic_1.id]
  vm_size                          = "Standard_B1s"
  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = var.iot_edge_ubuntu.publisher
    offer     = var.iot_edge_ubuntu.offer
    sku       = var.iot_edge_ubuntu.sku
    version   = var.iot_edge_ubuntu.version
  }

  storage_os_disk {
    name              = "${var.project_name}-iotedge-vm-disk-1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "tfm-iotedge-vm"
    admin_username = "adri"
    admin_password = var.password
  }

  plan {
    name      = var.iot_edge_ubuntu.sku
    publisher = var.iot_edge_ubuntu.publisher
    product   = var.iot_edge_ubuntu.offer
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags = var.tags
}

resource "azurerm_public_ip" "ioetdge_ip_1" {
  name                = "${var.project_name}-public-ip-1"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"

  tags = var.tags
}

resource "azurerm_network_interface" "nic_2" {
  name                = "${var.project_name}-nic-2"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "configuration"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.ioetdge_ip_2.id
  }
}

resource "azurerm_virtual_machine" "ioetdge_vm_2" {
  name                             = "${var.project_name}-iotedge-vm-2"
  location                         = data.azurerm_resource_group.rg.location
  resource_group_name              = data.azurerm_resource_group.rg.name
  network_interface_ids            = [azurerm_network_interface.nic_2.id]
  vm_size                          = "Standard_B1s"
  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = var.iot_edge_ubuntu.publisher
    offer     = var.iot_edge_ubuntu.offer
    sku       = var.iot_edge_ubuntu.sku
    version   = var.iot_edge_ubuntu.version
  }

  storage_os_disk {
    name              = "${var.project_name}-iotedge-vm-disk-2"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "tfm-iotedge-vm"
    admin_username = "adri"
    admin_password = var.password
  }

  plan {
    name      = var.iot_edge_ubuntu.sku
    publisher = var.iot_edge_ubuntu.publisher
    product   = var.iot_edge_ubuntu.offer
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags = var.tags
}

resource "azurerm_public_ip" "ioetdge_ip_2" {
  name                = "${var.project_name}-public-ip-2"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"

  tags = var.tags
}

resource "azurerm_network_interface" "nic_3" {
  name                = "${var.project_name}-nic-3"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "configuration"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.ioetdge_ip_3.id
  }
}

resource "azurerm_virtual_machine" "ioetdge_vm_3" {
  name                             = "${var.project_name}-iotedge-vm-3"
  location                         = data.azurerm_resource_group.rg.location
  resource_group_name              = data.azurerm_resource_group.rg.name
  network_interface_ids            = [azurerm_network_interface.nic_3.id]
  vm_size                          = "Standard_B1s"
  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = var.iot_edge_ubuntu.publisher
    offer     = var.iot_edge_ubuntu.offer
    sku       = var.iot_edge_ubuntu.sku
    version   = var.iot_edge_ubuntu.version
  }

  storage_os_disk {
    name              = "${var.project_name}-iotedge-vm-disk-3"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "tfm-iotedge-vm"
    admin_username = "adri"
    admin_password = var.password
  }

  plan {
    name      = var.iot_edge_ubuntu.sku
    publisher = var.iot_edge_ubuntu.publisher
    product   = var.iot_edge_ubuntu.offer
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags = var.tags
}

resource "azurerm_public_ip" "ioetdge_ip_3" {
  name                = "${var.project_name}-public-ip-3"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"

  tags = var.tags
}

