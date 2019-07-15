resource "azurerm_virtual_machine_extension" "join-domain" {
    name    = "sql-join-domain"
    location    ="${var.location}"
    resource_group_name = "${var.resource_group_name}"
    virtual_machine_name    = "${element(azurerm_virtual_machine.sqlservers.*.name, count.index)}"
    publisher               = "Microsoft.Compute"
    type                    = "JsonADDomainExtension"
    type_handler_version    = "1.3"
    count                   = "${var.sqlvmcount}"

    # OU Path Left blank to put servers in the Computers OU

    settings = <<SETTINGS
    {
        "Name": "${var.active_directory_domain}",
        "OUPath": "",
        "User": "${var.active_directory_domain}\\${var.active_directory_username}",
        "Restart": "true",
        "Options": "3"
    }
    SETTINGS

    protected_settings = <<SETTINGS
    {
        "Password": "${var.active_directory_password}"
    }
    SETTINGS
}

