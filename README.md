# Azure private nat vm Terraform module
Terraform module for virtual machine creation with NIC and iptables MASQUERADE configuration in custom data.

## Usage
This module is provisioning virtual machine with NIC. Below is an example that provisions VM with NIC and two subnets allowed in iptables configuration.
```
module "private-nat-vm" {
  source  = "data-platform-hq/private-nat-vm/azurerm"

  project              = var.project
  env                  = var.env
  location             = var.location
  resource_group       = var.resource_group
  vm_admin_credentials = var.vm_admin_credentials
  subnet_id            = var.shared_subnet_id
  subnet_cidrs         = [var.subnet_id1, var.subnet_id2]
  tags = var.tags
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements
| Name                                                                      | Version   |
|---------------------------------------------------------------------------|-----------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0  |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm)       | >= 3.23.0 |

## Providers

| Name                                                           | Version   |
|----------------------------------------------------------------|-----------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm)  | >= 3.23.0 |

## Modules

No modules.

## Resources

| Name                                                                                                                                            | Type     |
|-------------------------------------------------------------------------------------------------------------------------------------------------|----------|
| [azurerm_network_interface.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface)             | resource |
| [azurerm_linux_virtual_machine.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine)     | resource |

## Inputs

| Name                                                                                                                   | Description                                                                                                                                        | Type                                                                                                                      | Default                                                                                                                               | Required |
|------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------|:--------:|
| <a name="input_project"></a> [project](#input\_project)                                                                | Project name                                                                                                                                       | `string`                                                                                                                  | n/a                                                                                                                                   |   yes    |
| <a name="input_env"></a> [env](#input\_env)                                                                            | Environment name                                                                                                                                   | `string`                                                                                                                  | n/a                                                                                                                                   |   yes    |
| <a name="input_location"></a> [location](#input\_location)                                                             | Azure location                                                                                                                                     | `string`                                                                                                                  | n/a                                                                                                                                   |   yes    |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group)                                         | The name of the resource group in which to create resources                                                                                        | `string`                                                                                                                  | n/a                                                                                                                                   |   yes    |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id)                                                        | The ID of the Subnet where Network Interface should be located in                                                                                  | `string`                                                                                                                  | n/a                                                                                                                                   |   yes    |
| <a name="input_subnet_cidrs"></a> [subnet\_CIDRs](#input\_subnet\_CIDRs)                                               | CIDRs of subnets to be allowed on NAT instance                                                                                                     | `string`                                                                                                                  | n/a                                                                                                                                   |   yes    |
| <a name="input_vm_admin_credentials"></a> [vm\_admin\_credentials](#input\_vm\_admin\_credentials)                     | Username and public key used during virtual machine creation                                                                                       | <pre>object({<br> username    = string <br> public_key  = string <br>})</pre>                                             | n/a                                                                                                                                   |   yes    |
| <a name="input_suffix"></a> [suffix](#input\_suffix)                                                                   | Resource name suffix                                                                                                                               | `string`                                                                                                                  | `""`                                                                                                                                  |    no    |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size)                                                              | Virtual machine instance size                                                                                                                      | `string`                                                                                                                  | `Standard_B1ls`                                                                                                                       |    no    |
| <a name="input_use_custom_data"></a> [disable\_use\_custom\_data](#input\_use\_custom\_data)                           | Boolean flag which controls usage of provided custom data during virtual machine provisioning. True means to use.                                  | `bool`                                                                                                                    | `true`                                                                                                                                |    no    |
| <a name="input_encryption_at_host_enabled"></a> [encryption\_at\_host\_enabled](#input\_encryption\_at\_host\_enabled) | Boolean flag which controls Encryption at Host for all of the disks (including the temp disk) attached to this Virtual Machine. True means enable. | `bool`                                                                                                                    | `true`                                                                                                                                |    no    |
| <a name="input_tags"></a> [tags](#input\_tags)                                                                         | A mapping of tags to assign to the resource                                                                                                        | `map(any)`                                                                                                                | `{}`                                                                                                                                  |    no    |
| <a name="input_nic_ip_configuration"></a> [nic\_ip\_configuration](#input\_nic\_ip\_configuration)                     | Network interface card IP configuration                                                                                                            | <pre>object({<br>  name                          = string<br>  private_ip_address_allocation = string<br>})</pre>         | <pre>{<br>  name                          = "external"<br>  private_ip_address_allocation = "Dynamic"<br>}</pre>                      |    no    |
| <a name="input_vm_source_image_references"></a> [vm\_source\_image\_references](#input\_vm\_source\_image\_references) | Virtual machine source image references                                                                                                            | <pre>object({<br>  publisher = string<br>  offer     = string<br>  sku       = string<br>  version   = string<br>})</pre> | <pre>{<br>  publisher = "Canonical"<br>  offer     = "UbuntuServer"<br>  sku       = "18.04-LTS"<br>  version   = "latest"<br>}</pre> |    no    |
| <a name="input_vm_os_disk"></a> [vm\_os\_disk](#input\_vm\_os\_disk)                                                   | Virtual machine OS disk configuration                                                                                                              | <pre>object({<br>  caching              = string<br>  storage_account_type = string<br>})</pre>                           | <pre>{<br>  caching              = "None"<br>  storage_account_type = "Standard_LRS"<br>}</pre>                                       |    no    |

## Outputs

| Name                                                                                       | Description                             |
|--------------------------------------------------------------------------------------------|-----------------------------------------|
| <a name="azurerm_vm_private_ip"></a> [azurerm\_vm\_private\_ip](#azurerm\_vm\_private\_ip) | Private IP address of virtual machine.  |
<!-- END_TF_DOCS -->

## License

Apache 2 Licensed. For more information please see [LICENSE](https://github.com/data-platform-hq/terraform-azurerm-private-nat-vm/blob/main/LICENSE)
