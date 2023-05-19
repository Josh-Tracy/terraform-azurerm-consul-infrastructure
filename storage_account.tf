resource "azurerm_storage_account" "snapshots" {
  resource_group_name             = azurerm_resource_group.consul-rg.name
  location                        = azurerm_resource_group.consul-rg.location
  name                            = "${var.friendly_name_prefix}snapshots"
  account_kind                    = "StorageV2"
  account_tier                    = "Standard"
  access_tier                     = "Hot"
  account_replication_type        = "LRS"
  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = false

  network_rules {
    bypass                     = ["AzureServices"]
    default_action             = "Allow"
    ip_rules                   = var.sa_ingress_cidr_allow
    virtual_network_subnet_ids = [azurerm_subnet.consul-subnet.id]
  }

  tags = merge(
    { "Name" = "${var.friendly_name_prefix}snapshots" },
    var.common_tags
  )
}

resource "azurerm_storage_container" "snapshots" {
  name                  = "consul-snapshots"
  storage_account_name  = azurerm_storage_account.snapshots.name
  container_access_type = "private"

  depends_on = [
    azurerm_storage_account.snapshots
  ]

}