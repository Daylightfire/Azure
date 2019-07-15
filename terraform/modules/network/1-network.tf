#################################################################
##########
#   This module sets up the resource group, Virtual Network and its Subnets
##########
#################################################################

resource "azurerm_resource_group" "network" {
    name = "${var.resource_group_name}"
    location    = "${var.location}"
    
}

resource "azurerm_virtual_network" "main" {
    name                = "vn-${var.resource_group_name}"
    address_space       = ["${var.address_space}"]
    location            = "${var.location}"
    resource_group_name = "${azurerm_resource_group.network.name}"
    dns_servers         = "${var.dns_servers}"

    depends_on          = ["azurerm_resource_group.network"]
  
}

resource "azurerm_subnet" "hub-subnet" {
    name                    = "${var.hubsubnet_name}-${var.resource_group_name}"
    resource_group_name     = "${azurerm_resource_group.network.name}"
    virtual_network_name    = "${azurerm_virtual_network.main.name}"
    address_prefix          = "${var.hubsubnet_prefix}"
    network_security_group_id   = "${azurerm_network_security_group.hub-sec.id}"
}

resource "azurerm_subnet" "pres-subnet" {
    name                    = "${var.pressubnet_name}-${var.resource_group_name}"
    resource_group_name     = "${azurerm_resource_group.network.name}"
    virtual_network_name    = "${azurerm_virtual_network.main.name}"
    address_prefix          = "${var.pressubnet_prefix}"
    network_security_group_id   = "${azurerm_network_security_group.pres-sec.id}"
}

resource "azurerm_subnet" "app-subnet" {
    name                    = "${var.appsubnet_name}-${var.resource_group_name}"
    resource_group_name     = "${azurerm_resource_group.network.name}"
    virtual_network_name    = "${azurerm_virtual_network.main.name}"
    address_prefix          = "${var.appsubnet_prefix}"
}

resource "azurerm_subnet" "data-subnet" {
    name                    = "${var.datasubnet_name}-${var.resource_group_name}"
    resource_group_name     = "${azurerm_resource_group.network.name}"
    virtual_network_name    = "${azurerm_virtual_network.main.name}"
    address_prefix          = "${var.datasubnet_prefix}" 
    network_security_group_id   = "${azurerm_network_security_group.data-sec.id}"
}

