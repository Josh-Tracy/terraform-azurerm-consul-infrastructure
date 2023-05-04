#------------------------------------------------------------------------------
# Public IP
#------------------------------------------------------------------------------
resource "azurerm_public_ip" "bastion" {
  resource_group_name = azurerm_resource_group.primary-consul-rg.name
  location            = azurerm_resource_group.primary-consul-rg.location
  name                = "${var.friendly_name_prefix}-bastion-public-ip"
  allocation_method   = "Static"
  domain_name_label   = "${var.friendly_name_prefix}-bastion"

  tags = merge(
    { "Name" = "${var.friendly_name_prefix}-bastion-public-ip" },
    var.common_tags
  )
}

#------------------------------------------------------------------------------
# Network Interface
#------------------------------------------------------------------------------
resource "azurerm_network_interface" "bastion" {
  resource_group_name = azurerm_resource_group.primary-consul-rg.name
  location            = azurerm_resource_group.primary-consul-rg.location
  name                = "${var.friendly_name_prefix}-bastion-nic"

  ip_configuration {
    name                          = "ipconfig"
    subnet_id                     = azurerm_subnet.bastion.id
    public_ip_address_id          = azurerm_public_ip.bastion.id
    private_ip_address_allocation = "Dynamic"
  }

  tags = merge(
    { "Name" = "${var.friendly_name_prefix}-bastion-nic" },
    var.common_tags
  )
}

#------------------------------------------------------------------------------
# VM
#------------------------------------------------------------------------------
resource "azurerm_linux_virtual_machine" "bastion" {
  resource_group_name = azurerm_resource_group.primary-consul-rg.name
  location            = azurerm_resource_group.primary-consul-rg.location
  name                = "${var.friendly_name_prefix}-bastion"
  size                = "Standard_D1_v2"
  admin_username      = "consuladmin"

  network_interface_ids = [
    azurerm_network_interface.bastion.id
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
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }

  tags = merge(
    { "Name" = "${var.friendly_name_prefix}-bastion" },
    { "OS_distro" = "Ubuntu" },
    var.common_tags
  )
}