output "azurerm_vm_private_ip" {
  value       = azurerm_network_interface.this.private_ip_address
  description = "Private IP address of virtual machine"
}
