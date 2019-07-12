locals {
  jump_virtual_machine_name = "${var.jump_prefix}-01"
  jump_virtual_machine_fqdn = "${var.jump_prefix}.${var.active_directory_domain}"
}

resource "azurerm_virtual_machine" "jump-box" {
    name                    = "${local.jump_virtual_machine_name}"
    location                = "${var.location}"
    resource_group_name     = "${var.resource_group_name}"
    network_interface_ids   = ["${azurerm_network_interface.jump-nic.id}"]
    vm_size                 = "Standard_DS2_v2"

    delete_os_disk_on_termination    = true
    delete_data_disks_on_termination = true
    
        storage_image_reference {
            publisher   = "MicrosoftWindowsServer"
            offer       = "WindowsServer"
            sku         = "2016-Datacenter"
            version     = "latest"
        }

        storage_os_disk {
            name                = "${var.jump_prefix}-osdisk"
            caching             = "ReadWrite"
            create_option       = "FromImage"
            managed_disk_type   ="Standard_LRS"
        }

        storage_data_disk   {
            name            = "${var.jump_prefix}-datadisk1"
            caching         = "ReadWrite"
            create_option   = "Empty"
            disk_size_gb    = 200
            lun             = 1
        }
    
    os_profile  {
            computer_name   = "${local.jump_virtual_machine_name}"
            admin_username  = "${var.admin_username}"
            admin_password  = "${var.admin_password}"
        }

    os_profile_windows_config   {
            provision_vm_agent          = "true"
            enable_automatic_upgrades   = "true"
        }
}
