module "resource_group" {
  source   = "../../Modules/Resource_group"
  rg_name  = var.rg_name
  location = var.location
}

module "virtual_network" {
  depends_on = [module.resource_group]
  source     = "../../Modules/virtual_network"
  vnets      = var.vnets
}

module "Subnet" {
  depends_on = [module.virtual_network]
  source     = "../../Modules/Subnet"
  snets      = var.snets
}

module "public_ip" {
  depends_on = [module.resource_group]
  source     = "../../Modules/pip"
  pip        = var.pip
}

module "nic" {
  depends_on = [module.public_ip, module.Subnet]
  source     = "../../Modules/NIC"
  nics       = var.nics
}


module "virtual_machine" {
  depends_on = [module.nic]
  source     = "../../Modules/VM"
  vms        = var.vms
}

