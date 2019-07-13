#################################################################
##########
#   Network interfaces for Servers in the HUB Subnet
##########
#################################################################

# Jump box

resource "azurerm_public_ip" "jump-pip" {
    name                = "${var.jump_prefix}-pip"
    location            = "${var.location}"
    resource_group_name = "${var.resource_group_name}"
    allocation_method   = "Static"
}

resource "azurerm_network_interface" "jump-nic" {
    name                    = "${var.jump_prefix}-nic"
    location                = "${var.location}"
    resource_group_name     = "${var.resource_group_name}"
    internal_dns_name_label = "${local.jump_virtual_machine_name}"

    ip_configuration    {
        name                            = "${var.jump_prefix}-nicips"
        subnet_id                       = "${var.hub_subnet_id}"
        private_ip_address_allocation   = "static"
        private_ip_address              = "${var.jump_private_ip_address}"
        public_ip_address_id            = "${azurerm_public_ip.jump-pip.id}"
    }
}

# DC1 Server

resource "azurerm_network_interface" "dc1-nic" {
    name                = "${var.dc1_prefix}-nic"
    location            = "${var.location}"
    resource_group_name = "${var.resource_group_name}"
    internal_dns_name_label = "${local.dc1_virtual_machine_name}"

    ip_configuration    {
        name                            = "${var.dc1_prefix}-nicips"
        subnet_id                       = "${var.hub_subnet_id}"
        private_ip_address_allocation   = "static"
        private_ip_address              = "${var.dc1_private_ip_address}"
    }
  
}
