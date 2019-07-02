resource "azurerm_resource_group" "webapps" {
    name = "webapps"
    location = "${var.loc}"
    tags = "${var.tags}"
}

resource "random_string" "webapprnd" {
  length  = 8
  lower   = true
  number  = true
  upper   = false
  special = false
}

resource "azurerm_app_service_plan" "free" {
    count               = 3
    name                = "plan-free-${var.loc}"
    location            = "${var.webapplocs[count.index]}"
    resource_group_name = "${azurerm_resource_group.webapps.name}"
    tags                = "${azurerm_resource_group.webapps.tags}"

    kind                = "Linux"
    sku {
        tier = "Free"
        size = "F1"
    }
}

resource "azurerm_app_service" "citadel" {
    count               = 3
    name                = "webapp-${random_string.webapprnd.result}-${var.loc}"
    location            = "${var.webapplocs[count.index]}"
    resource_group_name = "${azurerm_resource_group.webapps.name}"
    tags                = "${azurerm_resource_group.webapps.tags}"

    app_service_plan_id = "${element(azurerm_app_service_plan.free.*.id, count.index)}"
}
