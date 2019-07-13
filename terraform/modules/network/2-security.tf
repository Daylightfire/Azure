#################################################################
##########
#   Network Security groups / Rules and their associations
##########
#################################################################

# Network security groups and Rules

resource "azurerm_network_security_group" "hub-sec" {
    name        = "${var.hubsubnet_name}-nsg"
    location    = "${var.location}"
    resource_group_name = "${var.resource_group_name}"

    security_rule   {
        name    = "${var.jumpext}"
        priority    = 150
        direction   = "Inbound"
        access      = "Allow"
        protocol    = "TCP"
        source_address_prefix   = "86.152.199.217"
        source_port_range   = "*"
        destination_address_prefix  = "*"
        destination_port_range  = "3389"
    }

    security_rule   {
        name    = "${var.hubrdp}"
        priority    = 155
        direction   = "Inbound"
        access      = "Allow"
        protocol    = "TCP"
        source_address_prefix   = "${var.jump_private_ip_address}"
        source_port_range   = "3389"
        destination_address_prefix  = "${var.hubsubnet_prefix}"
        destination_port_range  = "3389"
    }
    
}


# NSG Associations

resource "azurerm_subnet_network_security_group_association" "hub-sec-ass" {
    subnet_id   = "${azurerm_subnet.hub-subnet.id}"
    network_security_group_id   = "${azurerm_network_security_group.hub-sec.id}"  
}
