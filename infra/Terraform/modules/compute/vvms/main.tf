# Віртуальна мережа та підмережа вже існують в мережевому модулі

# Public IP для Load Balancer
resource "azurerm_public_ip" "lb_pip" {
  name                = "${var.vmss_name}-lb-pip"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Standard"
  allocation_method   = "Static"
  tags                = var.tags
}

# Load Balancer для VMSS
resource "azurerm_lb" "vmss_lb" {
  name                = "${var.vmss_name}-lb"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "${var.vmss_name}-lb-fe"
    public_ip_address_id = azurerm_public_ip.lb_pip.id
  }
}

# Backend Address Pool для LB
resource "azurerm_lb_backend_address_pool" "vmss_backend" {
  loadbalancer_id = azurerm_lb.vmss_lb.id
  name            = "vmss-backend-pool"
}

# NAT правила для SSH доступу
resource "azurerm_lb_nat_rule" "nat_ssh" {
  count                          = var.instance_count
  name                           = "SSH-NAT-${count.index}"
  resource_group_name            = var.resource_group_name
  loadbalancer_id                = azurerm_lb.vmss_lb.id
  frontend_ip_configuration_name = "${var.vmss_name}-lb-fe"
  protocol                       = "Tcp"
  frontend_port                  = 50001 + count.index
  backend_port                   = 22
}

# VM Scale Set
resource "azurerm_linux_virtual_machine_scale_set" "vmss" {
  name                 = var.vmss_name
  location             = var.location
  resource_group_name  = var.resource_group_name
  sku                  = var.vm_sku
  instances            = var.instance_count
  admin_username       = var.admin_username
  tags                 = var.tags
  computer_name_prefix = "${var.vmss_name}-vm"
  disable_password_authentication = true

  network_interface {
    name                      = "${var.vmss_name}-nic"
    primary                   = true
    network_security_group_id = azurerm_network_security_group.jenkins.id

    ip_configuration {
      name                                   = "${var.vmss_name}-ipconf"
      primary                                = true
      subnet_id                              = var.subnet_id
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.vmss_backend.id]
      # load_balancer_inbound_nat_rules_ids    = [for i in range(var.instance_count) : azurerm_lb_nat_rule.nat_ssh[i].id]
    }
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = 30  
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = var.sku
    version   = "latest"
  }

  upgrade_mode = "Manual"

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.ssh_public_key
  }
}

# Застосовуємо розширення для реєстрації DNS в privateDNS зоні
resource "azurerm_virtual_machine_scale_set_extension" "register_dns" {
  name                         = "register-dns"
  virtual_machine_scale_set_id = azurerm_linux_virtual_machine_scale_set.vmss.id
  publisher                    = "Microsoft.Azure.Extensions"
  type                         = "CustomScript"
  type_handler_version         = "2.0"
  auto_upgrade_minor_version   = true

  settings = jsonencode({
    "script": base64encode(<<-SCRIPT
      #!/bin/bash
      # Отримуємо hostname та IP адресу
      HOSTNAME=$(hostname)
      PRIVATE_IP=$(hostname -I | awk '{print $1}')
      
      # Реєструємо в logs для debugging
      echo "Hostname: $HOSTNAME, Private IP: $PRIVATE_IP" > /var/log/dns_register.log
    SCRIPT
    )
  })
}


# Security Group to allow Jenkins web and agent ports
resource "azurerm_network_security_group" "jenkins" {
  name                = "jenkins-nsg"
  location            = module.compute_rg.location
  resource_group_name = module.compute_rg.name
  tags                = var.tags

  security_rule {
    name                       = "allow-jenkins-web"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-jenkins-agent"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "50000"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}