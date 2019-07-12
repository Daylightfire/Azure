provider "azurerm" {
  # Whilst version is optional, we /strongly recommend/ using it to pin the version of the Provider being used
  version = "=1.31.0"
}

#########################################################
###########
##  Create Resource Group and Network + Subnets
###########
#########################################################

module "network" {
  source = "/mnt/d/WorkProjects/Azure/terraform/modules/network"
  address_space = "${var.address_space}"
  dns_servers   = "${var.dns_servers}"
  resource_group_name   = "${var.resource_group_name}"
  location      = "${var.location}"
  hubsubnet_name    = "${var.hubsubnet_name}"
  hubsubnet_prefix  = "${var.hubsubnet_prefix}"
  pressubnet_name   = "${var.pressubnet_name}"
  pressubnet_prefix = "${var.pressubnet_prefix}"
  appsubnet_name    = "${var.appsubnet_name}"
  appsubnet_prefix  = "${var.appsubnet_prefix}"
  datasubnet_name   = "${var.datasubnet_name}"
  datasubnet_prefix = "${var.datasubnet_prefix}"
}

########################################################
###########
#   Create Hub Layer Servers
###########
########################################################

# Jump Server

module "hubservers" {
  source = "/mnt/d/WorkProjects/Azure/terraform/modules/hubservers"
  resource_group_name           = "${var.resource_group_name}"
  location                      = "${var.location}"
  jump_prefix                   = "${var.jump_prefix}"
  hub_subnet_id                 = "${module.network.hubsubnet_subnet_id}"
  jump_private_ip_address       = "${var.jump_private_ip_address}"
  active_directory_domain       = "rootops.local"
  active_directory_netbios_name = "rootops"
  admin_username                = "${var.admin_username}"
  admin_password                = "${var.admin_password}"
}
