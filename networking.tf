resource "azurerm_virtual_network" "consul-vnet" {
  name                = "${var.friendly_name_prefix}-vnet"
  address_space       = var.vnet_cidr
  location            = azurerm_resource_group.consul-rg.location
  resource_group_name = azurerm_resource_group.consul-rg.name
}

resource "azurerm_subnet" "consul-subnet" {
  name                 = "${var.friendly_name_prefix}-subnet1"
  address_prefixes     = [var.consul_subnet_cidr]
  virtual_network_name = azurerm_virtual_network.consul-vnet.name
  resource_group_name  = azurerm_resource_group.consul-rg.name
  service_endpoints = [
    "Microsoft.Storage",
    "Microsoft.KeyVault"
  ]
}
resource "azurerm_nat_gateway" "nat_gateway" {
  name                    = "${var.friendly_name_prefix}-natgw"
  location                = azurerm_resource_group.consul-rg.location
  resource_group_name     = azurerm_resource_group.consul-rg.name
  sku_name                = "Standard"
  idle_timeout_in_minutes = 10
  zones                   = ["1"]
}

resource "azurerm_route_table" "route_table" {
  name                = "${var.friendly_name_prefix}-natgw-rt"
  location            = azurerm_resource_group.consul-rg.location
  resource_group_name = azurerm_resource_group.consul-rg.name

  route {
    name           = "DefaultRoute"
    address_prefix = "0.0.0.0/0"
    next_hop_type  = "Internet"
  }
}

resource "azurerm_subnet_route_table_association" "subnet_rt_association1" {
  subnet_id      = azurerm_subnet.consul-subnet.id
  route_table_id = azurerm_route_table.route_table.id
}