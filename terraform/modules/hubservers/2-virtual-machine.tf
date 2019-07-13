#################################################################
##########
#   Virtual Machines of the Hub Subnet
##########
#################################################################


locals {
  jump_virtual_machine_name = "${var.jump_prefix}-01"
  jump_virtual_machine_fqdn = "${var.jump_prefix}.${var.active_directory_domain}"
  dc1_virtual_machine_name  = "${var.dc1_prefix}-01"
  dc1_virtual_machine_fqdn  = "${local.dc1_virtual_machine_name}.${var.active_directory_domain}"
  custom_data_params        = "Params($RemoteHostName = \"${local.dc1_virtual_machine_fqdn}\", $ComputerName = \"${local.dc1_virtual_machine_name}\")"
  custom_data_content       = "${local.custom_data_params}${file("${path.module}/files/winrm.ps1")}"
}

# Create Jump box

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

# Create First Domain Controller

resource "azurerm_virtual_machine" "domain-controller" {
    name                    = "${local.dc1_virtual_machine_name}"
    location                = "${var.location}"
    resource_group_name     = "${var.resource_group_name}"
    network_interface_ids   = ["${azurerm_network_interface.dc1-nic.id}"]
    vm_size                 = "Standard_A4_v2"

    delete_os_disk_on_termination    = true
    delete_data_disks_on_termination = true

    storage_image_reference {
            publisher   = "MicrosoftWindowsServer"
            offer       = "WindowsServer"
            sku         = "2012-R2-Datacenter"
            version     = "latest"
        }
    
    storage_os_disk {
            name                = "${var.dc1_prefix}-osdisk"
            caching             = "ReadWrite"
            create_option       = "FromImage"
            managed_disk_type   = "Standard_LRS"
        }

    os_profile  {
            computer_name   = "${local.dc1_virtual_machine_name}"
            admin_username  = "${var.admin_username}"
            admin_password  = "${var.admin_password}"
        }

    os_profile_windows_config   {
            provision_vm_agent          = "true"
            enable_automatic_upgrades   = "true"
            
            additional_unattend_config  {
                pass            = "oobeSystem"
                component       = "Microsoft-Windows-Shell-Setup"
                setting_name    = "AutoLogon"
                content         = "<AutoLogon><Password><Value>${var.admin_password}</Value></Password><Enabled>true</Enabled><LogonCount>1</LogonCount><Username>${var.admin_username}</Username></AutoLogon>"
            }

            # Unattend config is to enable basic auth in WinRM, required for the provisioner stage.
            additional_unattend_config {
                pass            = "oobeSystem"
                component       = "Microsoft-Windows-Shell-Setup"
                setting_name    = "FirstLogonCommands"
                content         = "${file("${path.module}/files/FirstLogonCommands.xml")}"
            }
        }
}


