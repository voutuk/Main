# Access the existing VNET and Subnet
data "azurerm_virtual_network" "existing" {
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
}

data "azurerm_subnet" "existing" {
  name                 = var.subnet_name
  virtual_network_name = data.azurerm_virtual_network.existing.name
  resource_group_name  = var.resource_group_name
}

# Get SSH public key from Doppler secrets
data "doppler_secrets" "az_creds" {}

# Create network interfaces for each VM
resource "azurerm_network_interface" "vm_nic" {
  count               = var.vm_count
  name                = "nic-${var.vm_prefix}-${count.index}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.existing.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Create Azure VMs
resource "azurerm_linux_virtual_machine" "vm" {
  count               = var.vm_count
  name                = "${var.vm_prefix}-${count.index}"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.admin_username
  network_interface_ids = [
    azurerm_network_interface.vm_nic[count.index].id,
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = data.doppler_secrets.az_creds.map.SSHPUB
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.os_publisher
    offer     = var.os_offer
    sku       = var.os_sku
    version   = var.os_version
  }

  custom_data = base64encode(templatefile("${path.module}/templates/cloudflared_setup.tpl", {
    tunnel_id     = cloudflare_tunnel.ssh_tunnel[count.index].id,
    tunnel_name   = cloudflare_tunnel.ssh_tunnel[count.index].name,
    account_id    = var.cloudflare_account_id,
    tunnel_secret = cloudflare_tunnel.ssh_tunnel[count.index].secret
  }))

  depends_on = [cloudflare_tunnel.ssh_tunnel]
}

# Create Cloudflare Zero Trust tunnels
resource "cloudflare_tunnel" "ssh_tunnel" {
  count       = var.vm_count
  account_id  = var.cloudflare_account_id
  name        = "${var.tunnel_prefix}-${count.index}"
  secret      = random_id.tunnel_secret[count.index].b64_std
}

resource "random_id" "tunnel_secret" {
  count       = var.vm_count
  byte_length = 32
}

# Configure tunnel for SSH access
resource "cloudflare_tunnel_config" "ssh_config" {
  count      = var.vm_count
  account_id = var.cloudflare_account_id
  tunnel_id  = cloudflare_tunnel.ssh_tunnel[count.index].id
  
  config {
    ingress_rule {
      hostname = "${var.tunnel_prefix}${count.index}.${var.domain}"
      service  = "ssh://localhost:22"
    }
    
    ingress_rule {
      service = "http_status:404"
    }
  }
}

# Create DNS records for the tunnels
resource "cloudflare_record" "tunnel_dns" {
  count    = var.vm_count
  zone_id  = var.cloudflare_zone_id
  name     = "${var.tunnel_prefix}${count.index}"
  value    = "${cloudflare_tunnel.ssh_tunnel[count.index].id}.cfargotunnel.com"
  type     = "CNAME"
  proxied  = true
}