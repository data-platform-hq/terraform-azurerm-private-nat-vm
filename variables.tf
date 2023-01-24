variable "project" {
  type        = string
  description = "Project name"
}

variable "env" {
  type        = string
  description = "Environment name"
}

variable "location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists"
}

variable "resource_group" {
  type        = string
  description = "The name of the resource group in which to create resources"
}

variable "subnet_id" {
  type        = string
  description = "The ID of the Subnet where Network Interface should be located in"
}

variable "subnet_CIDRs" {
  type        = list(any)
  description = "CIDRs of subnets to be allowed on NAT instance"
}

variable "suffix" {
  type        = string
  description = "Resource name suffix"
  default     = ""
}

variable "vm_size" {
  type        = string
  description = "Virtual machine instance size"
  default     = "Standard_B1ls"
}

variable "use_custom_data" {
  type        = bool
  description = "Boolean flag which controls usage of provided custom data during virtual machine provisioning. True means to use."
  default     = true
}

variable "encryption_at_host_enabled" {
  type        = bool
  description = "Boolean flag which controls Encryption at Host for all of the disks (including the temp disk) attached to this Virtual Machine. True means enable"
  default     = true
}

variable "tags" {
  type        = map(any)
  description = "Resource tags"
  default     = {}
}

variable "nic_ip_configuration" {
  type        = object(any)
  description = "Network interface card IP configuration"
  default = {
    name                          = "external"
    private_ip_address_allocation = "Dynamic"
  }
}

variable "vm_source_image_references" {
  type        = object(any)
  description = "Virtual machine source image references"
  default = {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}

variable "vm_os_disk" {
  type        = object(any)
  description = "Virtual machine OS disk configuration"
  default = {
    caching              = "None"
    storage_account_type = "Standard_LRS"
  }
}

variable "vm_admin_credentials" {
  type = object({
    username   = string
    public_key = string
  })
  description = "Username and public key used during virtual machine creation"
}
