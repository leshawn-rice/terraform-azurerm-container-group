

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_name"></a> [name](#module\_name) | app.terraform.io/leshawn-rice/standard-naming/azurerm | n/a |
| <a name="module_tags"></a> [tags](#module\_tags) | app.terraform.io/leshawn-rice/tags/azurerm | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_container_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application"></a> [application](#input\_application) | n/a | `string` | `null` | no |
| <a name="input_business_unit"></a> [business\_unit](#input\_business\_unit) | n/a | `string` | `null` | no |
| <a name="input_containers"></a> [containers](#input\_containers) | A list of container definitions. Each object should include:<br/>- name, image, cpu, memory (required)<br/>- cpu\_limit, memory\_limit (optional)<br/>- environment\_variables, secure\_environment\_variables (optional)<br/>- commands (optional)<br/>- ports (optional list of port objects)<br/>- volume (optional single volume object) | <pre>list(object({<br/>    name         = string<br/>    image        = string<br/>    cpu          = number<br/>    memory       = number<br/>    cpu_limit    = optional(number)<br/>    memory_limit = optional(number)<br/><br/>    # Environment variables<br/>    environment_variables        = optional(map(string))<br/>    secure_environment_variables = optional(map(string))<br/><br/>    # Commands to execute on container start<br/>    commands = optional(list(string))<br/><br/>    # Ports<br/>    ports = optional(list(object({<br/>      port     = number<br/>      protocol = string<br/>    })))<br/><br/>    # Volume (optional)<br/>    volume = optional(object({<br/>      name                 = string<br/>      mount_path           = string<br/>      read_only            = optional(bool)<br/>      empty_dir            = optional(bool)<br/>      storage_account_name = optional(string)<br/>      storage_account_key  = optional(string)<br/>      share_name           = optional(string)<br/>      secret               = optional(map(string))<br/>    }))<br/>  }))</pre> | `[]` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | `null` | no |
| <a name="input_instance_number"></a> [instance\_number](#input\_instance\_number) | n/a | `string` | `null` | no |
| <a name="input_ip_address_type"></a> [ip\_address\_type](#input\_ip\_address\_type) | Specifies the IP address type for the container group (e.g., 'Public' or 'Private'). | `string` | `"Private"` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) The Azure Region where the Resource Group should exist. Changing this forces a new Resource Group to be created. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Optional) The Name which should be used for this Resource Group. Changing this forces a new Resource Group to be created.<br/><br/>  If 'name' is not passed, the 'names' module will be called to create a name | `string` | `null` | no |
| <a name="input_os_type"></a> [os\_type](#input\_os\_type) | The operating system type of the container group (e.g., 'Linux' or 'Windows'). | `string` | `"Linux"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the resource group in which to create the virtual network. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_service"></a> [service](#input\_service) | n/a | `string` | `null` | no |
| <a name="input_sku"></a> [sku](#input\_sku) | The SKU for the container group (e.g., 'Standard'). | `string` | `"Standard"` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | A list of subnet IDs to which this container group should be connected. | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags which should be assigned to the Resource Group<br/><br/>  If 'tags' is not passed, the 'tags' module will be called to create tags | `map(string)` | `null` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | n/a | <pre>object({<br/>    create = optional(string, "30m")<br/>    read   = optional(string, "30m")<br/>    update = optional(string, "5m")<br/>    delete = optional(string, "30m")<br/>  })</pre> | <pre>{<br/>  "create": "30m",<br/>  "delete": "30m",<br/>  "read": "30m",<br/>  "update": "5m"<br/>}</pre> | no |
| <a name="input_workload"></a> [workload](#input\_workload) | n/a | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Resource Group. |
| <a name="output_location"></a> [location](#output\_location) | The Azure Region where the Resource Group exists. |
| <a name="output_name"></a> [name](#output\_name) | The Name of the Resource Group. |
<!-- END_TF_DOCS -->