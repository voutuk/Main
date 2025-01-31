# Модуль створення Resource Group
module "resource_group" {
  source              = "./modules/resource_group"
  azure_region        = var.azure_region
  resource_group_name = var.resource_group_name
}

# Модуль створення Network Security Group
module "create_nsg" {
  source              = "./modules/nsg"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  nsg_name            = "vm-nsg"
  vnet_address_space  = "10.0.0.0/16"
}

# Основна VM
module "main_instance" {
  source              = "./modules/compute/main_instance"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  vm_name             = var.main_vm_name
  vm_size             = var.main_instance_vm_size
  admin_username      = var.vm_admin_username
  vm_private_ip       = var.vm_private_ip
  ssh_public_key      = data.doppler_secrets.az-creds.map.SSHPUB
  vm_sku              = var.vm_sku
  nsg_id              = module.create_nsg.nsg_id
}

# Build-Agent VM
module "build_agent_instance" {
  source              = "./modules/compute/build_agent_instance"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  vm_name             = "build-ub"
  subnet_id           = module.main_instance.subnet_id
  vm_size             = var.build_agent_vm_size
  admin_username      = var.vm_admin_username
  ssh_public_key      = data.doppler_secrets.az-creds.map.SSHPUB
  instance_count      = var.instance_count
  vm_sku              = var.vm_sku
  nsg_id              = module.create_nsg.nsg_id
}

# Модуль блоку SSH
module "rule_block_ssh" {
  source              = "./modules/nsg_rule"
  resource_group_name = module.resource_group.resource_group_name
  nsg_name            = "vm-nsg"
  priority            = 150
  depends_on          = [module.create_nsg]
}

# Модуль створення AKS кластера
module "aks_cluster" {
  source                     = "./modules/aks"
  resource_group_location    = var.resource_group_location
  resource_group_name_prefix = var.resource_group_name_prefix
  vm_size                    = var.aks_vm_size
  node_count                 = var.node_count
  username                   = var.username
  # pass the SSH data if needed
  ssh_public_key_data        = data.doppler_secrets.az-creds.map.SSHPUB
}