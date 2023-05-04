resource "azurerm_network_security_group" "consul-nsg" {
  name                = "${var.friendly_name_prefix}-consul-nsg"
  location            = azurerm_resource_group.primary-consul-rg.location
  resource_group_name = azurerm_resource_group.primary-consul-rg.name
}

resource "azurerm_network_security_rule" "consul_rpc_ingress" {
  resource_group_name          = azurerm_resource_group.primary-consul-rg.name
  network_security_group_name  = azurerm_network_security_group.consul-nsg.name
  name                         = "${var.friendly_name_prefix}-consul-rpc-ingress-8300"
  description                  = "Allow Consul server RPC traffic inbound"
  priority                     = 1001
  direction                    = "Inbound"
  access                       = "Allow"
  protocol                     = "Tcp"
  source_port_range            = "8300"
  destination_port_range       = "8300"
  source_address_prefixes      = var.vnet_cidr
  destination_address_prefixes = var.vnet_cidr
}

resource "azurerm_network_security_rule" "consul_rpc_egress" {
  resource_group_name          = azurerm_resource_group.primary-consul-rg.name
  network_security_group_name  = azurerm_network_security_group.consul-nsg.name
  name                         = "${var.friendly_name_prefix}-consul-rpc-egress-8300"
  description                  = "Allow Consul server RPC traffic outbound"
  priority                     = 1001
  direction                    = "Outbound"
  access                       = "Allow"
  protocol                     = "Tcp"
  source_port_range            = "8300"
  destination_port_range       = "8300"
  source_address_prefixes      = var.vnet_cidr
  destination_address_prefixes = var.vnet_cidr
}

resource "azurerm_network_security_rule" "consul_gossip_tcp_ingress" {
  resource_group_name          = azurerm_resource_group.primary-consul-rg.name
  network_security_group_name  = azurerm_network_security_group.consul-nsg.name
  name                         = "${var.friendly_name_prefix}-consul-gossip-tcp-ingress-8301-2"
  description                  = "Allow Consul gossip tcp traffic inbound"
  priority                     = 1002
  direction                    = "Inbound"
  access                       = "Allow"
  protocol                     = "Tcp"
  source_port_range            = "8301-8302"
  destination_port_range       = "8301-8302"
  source_address_prefixes      = var.vnet_cidr
  destination_address_prefixes = var.vnet_cidr
}

resource "azurerm_network_security_rule" "consul_gossip_tcp_egress" {
  resource_group_name          = azurerm_resource_group.primary-consul-rg.name
  network_security_group_name  = azurerm_network_security_group.consul-nsg.name
  name                         = "${var.friendly_name_prefix}-consul-gossip-tcp-egress-8301-2"
  description                  = "Allow Consul gossip tcp traffic outbound"
  priority                     = 1002
  direction                    = "Outbound"
  access                       = "Allow"
  protocol                     = "Tcp"
  source_port_range            = "8301-8302"
  destination_port_range       = "8301-8302"
  source_address_prefixes      = var.vnet_cidr
  destination_address_prefixes = var.vnet_cidr
}

resource "azurerm_network_security_rule" "consul_gossip_udp_ingress" {
  resource_group_name          = azurerm_resource_group.primary-consul-rg.name
  network_security_group_name  = azurerm_network_security_group.consul-nsg.name
  name                         = "${var.friendly_name_prefix}-consul-gossip-udp-ingress-8301-2"
  description                  = "Allow Consul gossip udp traffic inbound"
  priority                     = 1003
  direction                    = "Inbound"
  access                       = "Allow"
  protocol                     = "Udp"
  source_port_range            = "8301-8302"
  destination_port_range       = "8301-8302"
  source_address_prefixes      = var.vnet_cidr
  destination_address_prefixes = var.vnet_cidr
}

resource "azurerm_network_security_rule" "consul_gossip_udp_egress" {
  resource_group_name          = azurerm_resource_group.primary-consul-rg.name
  network_security_group_name  = azurerm_network_security_group.consul-nsg.name
  name                         = "${var.friendly_name_prefix}-consul-gossip-udp-egress-8301-2"
  description                  = "Allow Consul gossip udp traffic outbound"
  priority                     = 1003
  direction                    = "Outbound"
  access                       = "Allow"
  protocol                     = "Udp"
  source_port_range            = "8301-8302"
  destination_port_range       = "8301-8302"
  source_address_prefixes      = var.vnet_cidr
  destination_address_prefixes = var.vnet_cidr
}

resource "azurerm_network_security_rule" "consul_dns_tcp_ingress" {
  resource_group_name          = azurerm_resource_group.primary-consul-rg.name
  network_security_group_name  = azurerm_network_security_group.consul-nsg.name
  name                         = "${var.friendly_name_prefix}-consul-dns-tcp-ingress-8600"
  description                  = "Allow Consul DNS tcp traffic inbound"
  priority                     = 1004
  direction                    = "Inbound"
  access                       = "Allow"
  protocol                     = "Tcp"
  source_port_range            = "8600"
  destination_port_range       = "8600"
  source_address_prefixes      = var.vnet_cidr
  destination_address_prefixes = var.vnet_cidr
}

resource "azurerm_network_security_rule" "consul_dns_udp_ingress" {
  resource_group_name          = azurerm_resource_group.primary-consul-rg.name
  network_security_group_name  = azurerm_network_security_group.consul-nsg.name
  name                         = "${var.friendly_name_prefix}-consul-dns-udp-ingress-8600"
  description                  = "Allow Consul DNS udp traffic inbound"
  priority                     = 1005
  direction                    = "Inbound"
  access                       = "Allow"
  protocol                     = "Udp"
  source_port_range            = "8600"
  destination_port_range       = "8600"
  source_address_prefixes      = var.vnet_cidr
  destination_address_prefixes = var.vnet_cidr
}

resource "azurerm_subnet_network_security_group_association" "subnet_nsg_association1" {
  subnet_id                 = azurerm_subnet.primary-consul-subnet.id
  network_security_group_id = azurerm_network_security_group.consul-nsg.id
}

#------------------------------------------------------------------------------
# Bastion Subnet NSG
#------------------------------------------------------------------------------
resource "azurerm_network_security_group" "bastion" {
  resource_group_name = azurerm_resource_group.primary-consul-rg.name
  location            = azurerm_resource_group.primary-consul-rg.location
  name                = "${var.friendly_name_prefix}-bastion-nsg"

  tags = merge(
    { "Name" = "${var.friendly_name_prefix}-bastion-nsg" },
    var.common_tags
  )
}

resource "azurerm_network_security_rule" "bastion_ingress_ssh" {
  resource_group_name         = azurerm_resource_group.primary-consul-rg.name
  network_security_group_name = azurerm_network_security_group.bastion.name
  name                        = "${var.friendly_name_prefix}-bastion-ingress-ssh"
  description                 = "Allow list for SSH inbound to bastion."
  priority                    = 1001
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefixes     = var.bastion_ingress_cidr_allow
  destination_address_prefix  = var.bastion_subnet_cidr
}

resource "azurerm_subnet_network_security_group_association" "bastion" {
  subnet_id                 = azurerm_subnet.bastion.id
  network_security_group_id = azurerm_network_security_group.bastion.id
}