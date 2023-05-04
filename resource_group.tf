resource "azurerm_resource_group" "primary-consul-rg" {
  name     = "${var.friendly_name_prefix}-${var.primary_consul_rg}"
  location = var.primary_consul_rg_location
}