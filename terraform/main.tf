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
  address_space           = "${var.address_space}"
  dns_servers             = "${var.dns_servers}"
  resource_group_name     = "${var.resource_group_name}"
  location                = "${var.location}"
  hubsubnet_name          = "${var.hubsubnet_name}"
  hubsubnet_prefix        = "${var.hubsubnet_prefix}"
  pressubnet_name         = "${var.pressubnet_name}"
  pressubnet_prefix       = "${var.pressubnet_prefix}"
  appsubnet_name          = "${var.appsubnet_name}"
  appsubnet_prefix        = "${var.appsubnet_prefix}"
  datasubnet_name         = "${var.datasubnet_name}"
  datasubnet_prefix       = "${var.datasubnet_prefix}"
  jumpext                 = "${var.jumpext}"
  jump_private_ip_address = "${var.jump_private_ip_address}"
  hubrdp                  = "${var.hubrdp}"
  presrdp                 = "${var.presrdp}"
  datardp                 = "${var.datardp}"
}

########################################################
###########
#   Create Hub Layer Servers
###########
########################################################

module "hubservers" {
  source = "/mnt/d/WorkProjects/Azure/terraform/modules/hubservers"
  resource_group_name           = "${var.resource_group_name}"
  location                      = "${var.location}"
  jump_prefix                   = "${var.jump_prefix}"
  dc1_prefix                    = "${var.dc1_prefix}"
  hub_subnet_id                 = "${module.network.hubsubnet_subnet_id}"
  jump_private_ip_address       = "${var.jump_private_ip_address}"
  dc1_private_ip_address        = "${var.dc1_private_ip_address}"
  active_directory_domain       = "${var.active_directory_domain}"
  active_directory_netbios_name = "rootops"
  admin_username                = "${var.admin_username}"
  admin_password                = "${var.admin_password}"
  vmname                        = "${var.dc1_prefix}-01"

}

/*module "promote-dc" {
  source  = "/mnt/d/WorkProjects/Azure/terraform/modules/promotedc"
  active_directory_domain       = "rootops.local"
  active_directory_netbios_name = "rootops"
  admin_password                = "${var.admin_password}"
  location                      = "${var.location}"
  resource_group_name           = "${var.resource_group_name}"
  vmname                        = "${var.dc1_prefix}-01"
  
}*/


########################################################
###########
#   Create pres Layer Servers
###########
########################################################

module "presservers" {
  source = "/mnt/d/WorkProjects/Azure/terraform/modules/presservers"
  resource_group_name           = "${var.resource_group_name}"
  location                      = "${var.location}"
  web_prefix                    = "${var.web_prefix}"
  pres_subnet_id                = "${module.network.pressubnet_subnet_id}"
  web_private_ip_address        = "${var.web_private_ip_address}"
  active_directory_domain       = "${var.active_directory_domain}"
  active_directory_username     = "${var.admin_username}"
  active_directory_password     = "${var.admin_password}"
  active_directory_netbios_name = "rootops"
  admin_username                = "${var.admin_username}"
  admin_password                = "${var.admin_password}"

  
}




########################################################
###########
#   Create data Layer Servers
###########
########################################################

module "sql-vm" {
  source = "/mnt/d/WorkProjects/Azure/terraform/modules/sql-vm"
  resource_group_name = "${var.resource_group_name}"
  location            = "${var.location}"
  sql_prefix          = "${var.sql_prefix}"
  sqlpip_prefix       = "${var.sqlpip_prefix}"
  data_subnet_id           = "${module.network.datasubnet_subnet_id}"
  active_directory_domain       = "${var.active_directory_domain}"
  active_directory_username     = "${var.admin_username}"
  active_directory_password     = "${var.admin_password}"
  active_directory_netbios_name = "rootops"
  admin_username                = "${var.admin_username}"
  admin_password                = "${var.admin_password}"
  sqlvmcount                    = "${var.sqlvmcount}"
  lbprivate_ip_address          = "${var.lbprivate_ip_address}"  
}
