resource "azurerm_resource_group" "consul-rg" {
  name     = "${var.friendly_name_prefix}-${var.consul_rg}"
  location = var.consul_rg_location
}