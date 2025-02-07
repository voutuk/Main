variable "resource_group_name" { type = string }
variable "location"            { type = string }
variable "vm_name"             { type = string }
variable "vm_size"             { type = string }
variable "admin_username"      { type = string }
variable "ssh_public_key"      { type = string }
variable "vm_sku"              { type = string }
variable "nsg_id"              { type = string }
variable "subnet_id"           { type = string }
variable "instance_count"      { type = number }

# Add Public IP resource
resource "azurerm_public_ip" "build_agent_public_ip" {
  count               = var.instance_count
  name                = "${var.vm_name}-public-ip-${count.index}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_network_interface" "build_agent_nic" {
  count               = var.instance_count
  name                = "${var.vm_name}-nic-${count.index}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "ipconfig"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.1.${20 + count.index}"
    public_ip_address_id          = azurerm_public_ip.build_agent_public_ip[count.index].id  # Add public IP
  }
}

resource "azurerm_network_interface_security_group_association" "build_agent_nic_nsg" {
  count                     = var.instance_count
  network_interface_id      = azurerm_network_interface.build_agent_nic[count.index].id
  network_security_group_id = var.nsg_id
}

resource "azurerm_linux_virtual_machine" "build_agent_vm" {
  count               = var.instance_count
  name                = "${var.vm_name}-${count.index}"
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = var.vm_size
  admin_username      = var.admin_username

  network_interface_ids = [
    azurerm_network_interface.build_agent_nic[count.index].id
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.ssh_public_key
  }

  os_disk {
    name                 = "${var.vm_name}-osdisk-${count.index}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = var.vm_sku
    version   = "latest"
  }
}

