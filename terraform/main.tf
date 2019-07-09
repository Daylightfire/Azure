provider "azurerm" {
  # Whilst version is optional, we /strongly recommend/ using it to pin the version of the Provider being used
  version = "=1.31.0"
}

resource "azurerm_resource_group" "rg-poc" {
    name        = "rg-poc1"
    location    = "${var.loc}"
    tags        = "${var.tags}" 
}

resource "azurerm_virtual_network" "vn-poc" {
    name        = "vn-poc1"
    location    = "${azurerm_resource_group.rg-poc.location}"
    resource_group_name = "${azurerm_resource_group.rg-poc.name}"
    address_space   = ["10.1.0.0/16"]
  
}

resource "azurerm_subnet" "sn-poc-hub" {
    name        = "sn-poc1-hub"
    resource_group_name     = "${azurerm_resource_group.rg-poc.name}"
    virtual_network_name    = "${azurerm_virtual_network.vn-poc.name}"
    address_prefix  = "10.1.0.0/24"  
}
resource "azurerm_subnet" "sn-poc-pres" {
    name        = "sn-poc1-pres"
    resource_group_name     = "${azurerm_resource_group.rg-poc.name}"
    virtual_network_name    = "${azurerm_virtual_network.vn-poc.name}"
    address_prefix  = "10.1.1.0/24"
}

resource "azurerm_subnet" "sn-poc-app" {
    name        = "sn-poc1-app"
    resource_group_name     = "${azurerm_resource_group.rg-poc.name}"
    virtual_network_name    = "${azurerm_virtual_network.vn-poc.name}"
    address_prefix  = "10.1.2.0/24"
}

resource "azurerm_subnet" "sn-poc-data" {
    name        = "sn-poc1-data"
    resource_group_name     = "${azurerm_resource_group.rg-poc.name}"
    virtual_network_name    = "${azurerm_virtual_network.vn-poc.name}"
    address_prefix  = "10.1.3.0/24"
}

resource "azurerm_network_security_group" "nsg-poc-hub" {
    name        = "nsg-poc1-hub"
    location    = "${azurerm_resource_group.rg-poc.location}"
    resource_group_name = "${azurerm_resource_group.rg-poc.name}"

    security_rule   {
        name    = "Jumpaccess"
        priority    = 150
        direction   = "Inbound"
        access      = "Allow"
        protocol    = "TCP"
        source_address_prefix   = "86.170.112.6"
        source_port_range   = "*"
        destination_address_prefix  = "*"
        destination_port_range  = "3389"
    }
    
}

resource "azurerm_public_ip" "pip-hub-jump1" {
    name    = "jump-pip"
    location    = "${azurerm_resource_group.rg-poc.location}"
    resource_group_name = "${azurerm_resource_group.rg-poc.name}"
    allocation_method = "Static"
}

resource "azurerm_network_interface" "nic-hub-jump" {
    name    = "jump-nic"
    location    = "${azurerm_resource_group.rg-poc.location}"
    resource_group_name = "${azurerm_resource_group.rg-poc.name}"

    ip_configuration    {
        name    = "nicconf"
        subnet_id   = "${azurerm_subnet.sn-poc-hub.id}"
        private_ip_address_allocation   = "static"
        private_ip_address  = "10.1.0.5"
        public_ip_address_id    = "${azurerm_public_ip.pip-hub-jump1.id}"
    }
}

resource "azurerm_virtual_machine" "hub-jump" {
        name    = "vm-poc-hub-jump"
        location    = "${azurerm_resource_group.rg-poc.location}"
        resource_group_name = "${azurerm_resource_group.rg-poc.name}"
        network_interface_ids   = ["${azurerm_network_interface.nic-hub-jump.id}"]
        vm_size = "Standard_DS1_v2"

        delete_os_disk_on_termination = true
        delete_data_disks_on_termination = true

        storage_image_reference {
            publisher   = "MicrosoftWindowsServer"
            offer       = "WindowsServer"
            sku         = "2016-Datacenter"
            version     = "latest"
        }

        storage_os_disk {
            name    = "jump-osdisk"
            caching = "ReadWrite"
            create_option   = "FromImage"
            managed_disk_type   ="Standard_LRS"
        }

        os_profile  {
            computer_name   = "jr-jump01"
            admin_username  = "*****"
            admin_password  = "*********"
        }
  
        os_profile_windows_config   {
            provision_vm_agent  = "false"
        }

        storage_data_disk   {
            name    = "jump-datadisk1"
            caching = "ReadWrite"
            create_option   = "Empty"
            disk_size_gb    = 200
            lun = 1

        }
}



