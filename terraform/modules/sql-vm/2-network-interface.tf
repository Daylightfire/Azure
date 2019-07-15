resource "azurerm_network_interface" "sql-nic" {
    name        = "${var.sql_prefix}-sql${1 + count.index}-int"
    location    = "${var.location}"
    resource_group_name         = "${var.resource_group_name}"
    internal_dns_name_label     = "${var.sql_prefix}-sql${1 + count.index}"
    count                       = "${var.sqlvmcount}"

    ip_configuration    {
        name    = "${var.sql_prefix}-nic"
        subnet_id   = "${var.data_subnet_id}"
        private_ip_address_allocation   = "static"
        private_ip_address  = "${var.sqlpip_prefix}${10 + count.index}"
        #load_balancer_backend_address_pools_ids = ["${azurerm_lb_backend_address_pool.sql-loadbalancer-backend.id}"]
        
    }
 
}

resource "azurerm_network_interface_backend_address_pool_association" "sqllba" {
    network_interface_id    = "${element(azurerm_network_interface.sql-nic.*.id, count.index)}"
    ip_configuration_name   = "${var.sql_prefix}-nic"
    backend_address_pool_id = "${azurerm_lb_backend_address_pool.sql-loadbalancer-backend.id}"
    count                   = "${var.sqlvmcount}"
}



