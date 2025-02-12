# INFO: Build Agent Variables
variable "location" {
  type        = string
  description = "The Azure region where build agent resources will be created"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "instance_count" {
  type        = number
  description = "Number of build agent instances to create"
  default     = 1
}

variable "vm_name" {
  type        = string
  description = "Base name for the VM instances"
}

variable "vm_size" {
  type        = string
  description = "The size of the VM"
}

variable "admin_username" {
  type        = string
  description = "Admin username for the VM"
}

variable "ssh_public_key" {
  type        = string
  description = "SSH public key for VM access"
}

variable "vm_sku" {
  type        = string
  description = "The SKU of the VM image"
}

variable "nsg_id" {
  type        = string
  description = "Network Security Group ID"
}

# Create a new virtual network for build agents
resource "azurerm_virtual_network" "build_agent_vnet" {
  name                = "agent-vnet"
  address_space       = ["10.1.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
}

# Create a subnet for build agents
resource "azurerm_subnet" "build_agent_subnet" {
  name                 = "agent-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.build_agent_vnet.name
  address_prefixes     = ["10.1.1.0/24"]
}

# Network Interface resource
# Network Interface resource
resource "azurerm_network_interface" "build_agent_nic" {
  count               = var.instance_count
  name                = "agent-nic-${count.index}"
  location            = var.location
  resource_group_name = var.resource_group_name

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

# INFO: Build Agent Outputs
output "private_ips" {
  value       = [for nic in azurerm_network_interface.build_agent_nic : nic.private_ip_address]
  description = "List of private IP addresses for build agents"
}

output "public_ips" {
  value       = [for pip in azurerm_public_ip.build_agent_pip : pip.ip_address]
  description = "List of public IP addresses for build agents"
}

output "vm_names" {
  value       = [for vm in azurerm_linux_virtual_machine.build_agent_vm : vm.name]
  description = "List of build agent VM names"
}