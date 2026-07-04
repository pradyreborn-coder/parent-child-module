module "rg" {
  source = "./modules/rg"
  rg     = var.rg
}

module "vnet" {
  source   = "./modules/vnet"
  vnet     = var.vnet
  rgs_info = module.rg.rgs_info
}

module "subnet" {
  source     = "./modules/subnet"
  snet       = var.subnet
  rgs_info   = module.rg.rgs_info
  vnets_info = module.vnet.vnets_info
}

module "nsg" {
  source   = "./modules/nsg"
  nsg      = var.nsg
  rgs_info = module.rg.rgs_info
}

module "pip" {
  source   = "./modules/pip"
  pip      = var.pip
  rgs_info = module.rg.rgs_info
}

module "nic" {
  source       = "./modules/nic"
  nic          = var.nic
  rgs_info     = module.rg.rgs_info
  subnets_info = module.subnet.subnets_info
}

module "vm" {
  source    = "./modules/vm"
  vm1       = var.vm1
  vm2       = var.vm2
  rgs_info  = module.rg.rgs_info
  nics_info = module.nic.nics_info
}

module "bastion" {
  source       = "./modules/bastion"
  bastion      = var.bastion
  rgs_info     = module.rg.rgs_info
  subnets_info = module.subnet.subnets_info
  pips_info    = module.pip.pips_info
}

module "vnetpeering" {
  source       = "./modules/vnetpeering"
  vnet_peering = var.vnet_peering
  rgs_info     = module.rg.rgs_info
  vnets_info   = module.vnet.vnets_info
}

module "lb" {
  source    = "./modules/lb"
  lb        = var.lb
  rgs_info  = module.rg.rgs_info
  nics_info = module.nic.nics_info
}

module "sa" {
  source   = "./modules/sa"
  sa_name  = var.sa_name
  rgs_info = module.rg.rgs_info
}