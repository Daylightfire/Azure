#############################################################################
#   Outputs
############################################################################

output "hubsubnet_subnet_id" {
  value = "${azurerm_subnet.hub-subnet.id}"
}

output "pressubnet_subnet_id" {
  value = "${azurerm_subnet.pres-subnet.id}"
}

output "appsubnet_subnet_id" {
  value = "${azurerm_subnet.app-subnet.id}"
}

output "datasubnet_subnet_id" {
  value = "${azurerm_subnet.data-subnet.id}"
}

output "out_resource_group_name" {
  value = "${azurerm_resource_group.network.name}"
}
