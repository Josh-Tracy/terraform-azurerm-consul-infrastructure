resource "azurerm_network_interface" "consul-subnet" {
  for_each = var.deploy_virtual_machines == true ? var.vm_settings : null

  name                = each.key
  location            = azurerm_resource_group.primary-consul-rg.location
  resource_group_name = azurerm_resource_group.primary-consul-rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.primary-consul-subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "consul-servers" {
  for_each = var.deploy_virtual_machines == true ? var.vm_settings : null

  name                = each.key
  resource_group_name = azurerm_resource_group.primary-consul-rg.name
  location            = azurerm_resource_group.primary-consul-rg.location
  size                = "Standard_F2"
  admin_username      = "consuladmin"
  zone                = each.value.zone
  network_interface_ids = [
    azurerm_network_interface.consul-subnet[each.key].id,
  ]

  admin_ssh_key {
    username   = "consuladmin"
    public_key = file("consul.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
