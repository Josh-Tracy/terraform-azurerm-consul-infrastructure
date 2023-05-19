output "privatE_instance_ip_addr" {
  value = values(azurerm_linux_virtual_machine.consul-servers)[*].private_ip_address
}

output "public_instance_ip_addr" {
  value = values(azurerm_linux_virtual_machine.consul-servers)[*].public_ip_address
}