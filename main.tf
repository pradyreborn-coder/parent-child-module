module "rg" {
  source = "./modules/rg"
  rg     = var.rg
}

module "vnet" {
  source     = "./modules/vnet"
  vnet       = var.vnet
  depends_on = [module.rg]
}

module "subnet" {
  source     = "./modules/subnet"
  snet       = var.subnet
  depends_on = [module.vnet]
}

module "nsg" {
  source     = "./modules/nsg"
  nsg        = var.nsg
  depends_on = [module.rg]
}

module "pip" {
  source     = "./modules/pip"
  pip        = var.pip
  depends_on = [module.rg]
}

module "nic" {
  source     = "./modules/nic"
  nic        = var.nic
  subnet_ids = module.subnet.subnet_ids
  depends_on = [module.subnet]
}

module "vm" {
  source     = "./modules/vm"
  vm1        = var.vm1
  vm2        = var.vm2
  nic_ids    = module.nic.nic_ids
  depends_on = [module.nic]
}

module "bastion" {
  source     = "./modules/bastion"
  bastion    = var.bastion
  subnet_ids = module.subnet.subnet_ids
  pip_ids    = module.pip.pip_ids
  depends_on = [module.pip, module.subnet]
}

module "vnetpeering" {
  source       = "./modules/vnetpeering"
  vnet_peering = var.vnet_peering
  vnet_ids     = module.vnet.vnet_ids
  depends_on   = [module.vnet]
}
