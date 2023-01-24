locals {
  suffix = length(var.suffix) == 0 ? "" : "-${var.suffix}"
}

resource "azurerm_network_interface" "this" {
  name                 = "nic-${var.project}-${var.env}-${var.location}${local.suffix}"
  location             = var.location
  resource_group_name  = var.resource_group
  enable_ip_forwarding = true

  ip_configuration {
    name                          = var.nic_ip_configuration.name
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.nic_ip_configuration.private_ip_address_allocation
  }

  tags = var.tags
}

resource "azurerm_linux_virtual_machine" "this" {
  name                = "vm-${var.project}-${var.env}-${var.location}${local.suffix}"
  resource_group_name = var.resource_group
  location            = var.location
  size                = var.vm_size
  admin_username      = var.vm_admin_credentials.username
  custom_data = var.use_custom_data ? base64encode(templatefile("${path.module}/files/custom_data.sh.tpl",
  { SUBNET_CIDRS = join(",", var.subnet_cidrs) })) : null
  encryption_at_host_enabled = var.encryption_at_host_enabled
  network_interface_ids      = [azurerm_network_interface.this.id]

  admin_ssh_key {
    username   = var.vm_admin_credentials.username
    public_key = var.vm_admin_credentials.public_key
  }

  os_disk {
    caching              = var.vm_os_disk.caching
    storage_account_type = var.vm_os_disk.storage_account_type
  }

  source_image_reference {
    publisher = var.vm_source_image_references.publisher
    offer     = var.vm_source_image_references.offer
    sku       = var.vm_source_image_references.sku
    version   = var.vm_source_image_references.version
  }

  tags = var.tags
}
