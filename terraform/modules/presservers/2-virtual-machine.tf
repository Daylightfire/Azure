#################################################################
##########
#  Servers in the Pres subnet
##########
#################################################################
locals {
  virtual_machine_name  = "${var.web_prefix}-01"
}


resource "azurerm_virtual_machine" "web-server" {
    name    = "${local.virtual_machine_name}"
    location    = "${var.location}"
    resource_group_name = "${var.resource_group_name}"
    network_interface_ids   = ["${azurerm_network_interface.web-nic.id}"]
    vm_size = "Standard_DS2_v2"

    delete_os_disk_on_termination   = true
    delete_data_disks_on_termination = true
    
    storage_image_reference {
        publisher   = "MicrosoftWindowsServer"
        offer       = "WindowsServer"
        sku         = "2012-R2-Datacenter"
        version     = "latest"
    }

    storage_os_disk {
        name    = "${local.virtual_machine_name}-osdisk"
        caching = "ReadWrite"
        create_option   = "FromImage"
        managed_disk_type   = "Standard_LRS"
    }

    os_profile  {
        computer_name   = "${local.virtual_machine_name}"
        admin_username  = "${var.admin_username}"
        admin_password  = "${var.admin_password}"
    }
    
    storage_data_disk   {
            name            = "${local.virtual_machine_name}-datadisk"
            caching         = "ReadWrite"
            create_option   = "Empty"
            disk_size_gb    = 200
            lun             = 1
    } 

    os_profile_windows_config {
    provision_vm_agent = true
    enable_automatic_upgrades = true
    }

    depends_on = ["azurerm_network_interface.web-nic"]
}
