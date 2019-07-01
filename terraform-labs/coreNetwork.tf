resource "azurerm_resource_group" "core" {
    name        = "core"
    location    = "${var.loc}"
    tags        = "${var.tags}"
}

resource "azurerm_public_ip" "vpnGatewayPublicIp" {
    name                = "vpnGatewayPublicIp"
    location            = "${azurerm_resource_group.core.location}"
    resource_group_name = "${azurerm_resource_group.core.name}"
    tags                = "${azurerm_resource_group.core.tags}"

    allocation_method   = "Dynamic"
}

resource "azurerm_virtual_network" "core" {
    name                = "core"
    location            = "${azurerm_resource_group.core.location}"
    resource_group_name = "${azurerm_resource_group.core.name}"
    address_space       = ["10.0.0.0/16"]
    dns_servers         = ["1.1.1.1", "1.0.0.1"]

    subnet  {
        name            = "training"
        address_prefix  = "10.0.1.0/24"
    }

    subnet  {
        name            = "dev"
        address_prefix  = "10.0.2.0/24"
    }
}

resource "azurerm_subnet" "GatewaySubnet" {
    name                = "GatewaySubnet"
    virtual_network_name = "${azurerm_virtual_network.core.name}"
    resource_group_name = "${azurerm_resource_group.core.name}"
    address_prefix      = "10.0.0.0/24"
}


/*resource "azurerm_virtual_network_gateway" "vpnGateway" {
    name                = "vpnGateway"
    location            = "${azurerm_resource_group.core.location}"
    resource_group_name = "${azurerm_resource_group.core.name}"

    type        = "vpn"
    vpn_type    = "RouteBased"

    enable_bgp  = "true"
    sku         = "Basic"

    ip_configuration    {
        name    = "vpnGwConfig1"
        public_ip_address_id    = "${azurerm_public_ip.vpnGatewayPublicIp.id}"
        private_ip_address_allocation   = "Dynamic"
        subnet_id                       = "${azurerm_subnet.GatewaySubnet.id}"
    }
}*/


