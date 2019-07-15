#################################################################
##########
#   Network interfaces for Servers in the Pres subnet
##########
#################################################################

resource "azurerm_network_interface" "web-nic" {
    name    = "${var.web_prefix}-nic"
    location    = "${var.location}"
    resource_group_name = "${var.resource_group_name}"
    internal_dns_name_label = "${var.web_prefix}-01"

    ip_configuration    {
        name    = "${var.web_prefix}-nicips"
        subnet_id   = "${var.pres_subnet_id}"
        private_ip_address_allocation   = "static"
        private_ip_address  = "${var.web_private_ip_address}"
    } 
}
