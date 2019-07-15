resource "azurerm_lb" "sql-loadbalancer" {
    name    = "${var.sql_prefix}-sqllb"
    resource_group_name = "${var.resource_group_name}"
    location            = "${var.location}"
    sku                 = "Standard"
    frontend_ip_configuration   {
        name    = "sqlLoadBalancerFrontEnd"
        subnet_id   = "${var.data_subnet_id}"
        private_ip_address_allocation   = "Static"
        private_ip_address  = "${var.lbprivate_ip_address}"
    }
}

resource "azurerm_lb_backend_address_pool" "sql-loadbalancer-backend" {
    name    = "loadbalancer_backend"
    resource_group_name = "${var.resource_group_name}"
    loadbalancer_id     = "${azurerm_lb.sql-loadbalancer.id}"  
}

resource "azurerm_lb_probe" "loadbalancer_probe" {
      resource_group_name   = "${var.resource_group_name}"
      loadbalancer_id       = "${azurerm_lb.sql-loadbalancer.id}"
      name                  = "SQLAlwaysOnEndPointProbe"
      protocol              = "tcp"
      port                  = 59999
      interval_in_seconds   = 5
      number_of_probes      = 2
}

resource "azurerm_lb_rule" "SQLAlwaysOnEndPointListener" {
    resource_group_name = "${var.resource_group_name}"
    loadbalancer_id     = "${azurerm_lb.sql-loadbalancer.id}"
    name                = "SQLAlwaysOnEndPointListener"
    protocol            = "Tcp"
    frontend_port       = 1433
    backend_port        = 1433
    frontend_ip_configuration_name  = "sqlLoadBalancerFrontEnd"
    backend_address_pool_id         = "${azurerm_lb_backend_address_pool.sql-loadbalancer-backend.id}"
    probe_id                        = "${azurerm_lb_probe.loadbalancer_probe.id
    }"
}



