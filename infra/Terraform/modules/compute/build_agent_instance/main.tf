# modules/compute/build_agent_instance/main.tf


# Create a new virtual network for build agents
resource "azurerm_virtual_network" "build_agent_vnet" {
  name                = "agent-vnet"
  address_space       = ["10.1.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
  tags = var.tags
}

# Create a subnet for build agents
resource "azurerm_subnet" "build_agent_subnet" {
  name                 = "agent-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.build_agent_vnet.name
  address_prefixes     = ["10.1.1.0/24"]
}

# Network Interface resource
resource "azurerm_network_interface" "build_agent_nic" {
  count               = var.instance_count
  name                = "agent-nic-${count.index}"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags = var.tags

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.build_agent_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.build_agent_pip[count.index].id  # Add this line
  }
}

# Optional: Add public IP if needed
resource "azurerm_public_ip" "build_agent_pip" {
  count               = var.instance_count
  name                = "agent-pip-${count.index}"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Dynamic"
  sku                = "Basic"
  tags = var.tags
}

# Network Security Group for build agents
resource "azurerm_network_interface_security_group_association" "vm_nic_nsg" {
  count                     = var.instance_count
  network_interface_id      = azurerm_network_interface.build_agent_nic[count.index].id
  network_security_group_id = var.nsg_id
}

# Create the build-agent Linux VMs
resource "azurerm_linux_virtual_machine" "build_agent_vm" {
  count               = var.instance_count
  name                = "${var.vm_name}-${count.index}"
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = var.vm_size
  admin_username      = var.admin_username
  tags = var.tags

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